import { Component, ViewChild, ElementRef, AfterViewInit, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import * as d3 from 'd3';
import { ProblemService } from 'src/app/domain/services/problem.service';
import { LinkService } from 'src/app/domain/services/link.service';
import { Location } from '@angular/common';
import { Observable, Subscription } from 'rxjs';
import { CompareGraphsService } from 'src/app/compare-graphs/services/compare-graph.service';
import { KsService } from 'src/app/knowledge-space/services/ks.service';

@Component({
  selector: 'app-d3',
  templateUrl: './d3.component.html',
  styleUrls: ['./d3.component.css']
})
export class D3Component implements AfterViewInit, OnInit {

  title = 'ng-d3-graph-editor';
  @ViewChild('graphContainer') graphContainer: ElementRef;

  @Input() events: Observable<void>;
  public eventsSubscription: Subscription;
  public selectedKs: string;
  public testId: string;

  width = 960;
  height = 600;
  colors = d3.scaleOrdinal(d3.schemeCategory10);

  svg: any;
  force: any;
  path: any;
  circle: any;
  public text: any;
  drag: any;
  dragLine: any;
  graphSimilarityPercent: any;

  // mouse event vars
  public selectedNode = null;
  public selectedLink = null;
  public titleInputFocus = false;
  mousedownLink = null;
  mousedownNode = null;
  mouseupNode = null;

  lastNodeId = 99;
  lastKeyDown = -1; // only respond once per keydown

  public nodes = [];
  public links = [];
  public data: any;
  public editable = false;

  constructor(
    private route: ActivatedRoute,
    private problemService: ProblemService,
    private linkService: LinkService,
    private _location: Location,
    private comparedKsService: CompareGraphsService,
    private realKsService: KsService
  ) {}

  ngOnInit(){
    console.log('Data: ', this.route.snapshot.data["data"]);
    if(this.events) {
      this.eventsSubscription = this.events.subscribe(response => this.updateKS(response));
      this.testId = this.route.snapshot.data["data"]['test']['id'];
    }
    this.data = this.route.snapshot.data["data"];
    if(this.data['domain']) {
      this.editable = true;
      this.nodes = this.data['domain']['problems'];
      this.links = this.data['domain']['links'];
    }
    this.lastNodeId = this.nodes ? this.nodes.length: 0;
  }

  ngAfterViewInit() {
    const rect = this.graphContainer.nativeElement.getBoundingClientRect();
    this.width = rect.width;
    this.svg = d3.select('#graphContainer')
      .attr('oncontextmenu', 'return false;')
      .attr('width', this.width)
      .attr('height', this.height);
    this.force = d3.forceSimulation()
      .force('link', d3.forceLink().id((d: any) => d.id).distance(150))
      .force('charge', d3.forceManyBody().strength(-500))
      .force('x', d3.forceX(this.width / 2))
      .force('y', d3.forceY(this.height / 2))
      .on('tick', () => this.tick());
    // // init D3 drag support
    this.drag = d3.drag()
      .on('start', (d: any) => {
        if (!d3.event.active) this.force.alphaTarget(0.3).restart();
        // d.fx = d.x;
        // d.fy = d.y;
      })
      .on('drag', (d: any) => {
        d.fx = d3.event.x;
        d.fy = d3.event.y;
      })
      .on('end', (d: any) => {
        if (!d3.event.active) this.force.alphaTarget(0.3);
        d.fx = null;
        d.fy = null;
      });
    // define arrow markers for graph links
    this.svg.append('svg:defs').append('svg:marker')
      .attr('id', 'end-arrow')
      .attr('viewBox', '0 -5 10 10')
      .attr('refX', 6)
      .attr('markerWidth', 3)
      .attr('markerHeight', 3)
      .attr('orient', 'auto')
      .append('svg:path')
      .attr('d', 'M0,-5L10,0L0,5')
      .attr('fill', '#000');
    this.svg.append('svg:defs').append('svg:marker')
      .attr('id', 'start-arrow')
      .attr('viewBox', '0 -5 10 10')
      .attr('refX', 4)
      .attr('markerWidth', 3)
      .attr('markerHeight', 3)
      .attr('orient', 'auto')
      .append('svg:path')
      .attr('d', 'M10,-5L0,0L10,5')
      .attr('fill', '#000');
    // line displayed when dragging new nodes
    this.dragLine = this.svg.append('svg:path')
      .attr('class', 'link dragline hidden')
      .attr('d', 'M0,0L0,0');
    // handles to link and node element groups
    this.path = this.svg.append('svg:g').selectAll('path');
    this.circle = this.svg.append('svg:g').selectAll('g');
    // app starts here
    this.svg.on('mousedown', (dataItem, value, source) => this.mousedown(dataItem, value, source))
      .on('mousemove', (dataItem) => this.mousemove(dataItem))
      .on('mouseup', (dataItem) => this.mouseup(dataItem));
    d3.select(window)
      .on('keydown', (selected) => this.keydown(selected))
      .on('keyup', this.keyup);
    this.restart();
  }

  // update force layout (called automatically each iteration)
  public tick() {
    this.updateLinkNodes();
    // draw directed edges with proper padding from node centers
    this.path.attr('d', (d: any) => {
      const deltaX = d.target.x - d.source.x;
      const deltaY = d.target.y - d.source.y;
      const dist = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
      const normX = deltaX / dist;
      const normY = deltaY / dist;
      const sourcePadding = d.left ? 17 : 12;
      const targetPadding = d.right ? 17 : 12;
      const sourceX = d.source.x + (sourcePadding * normX);
      const sourceY = d.source.y + (sourcePadding * normY);
      const targetX = d.target.x - (targetPadding * normX);
      const targetY = d.target.y - (targetPadding * normY);
      return `M${sourceX},${sourceY}L${targetX},${targetY}`;
    });
    this.circle.attr('transform', (d) => `translate(${d.x},${d.y})`);
  }

  resetMouseVars() {
    this.mousedownNode = null;
    this.mouseupNode = null;
    this.mousedownLink = null;
  }

  // update graph (called when needed)
  public restart() {
    // path (link) group
    this.path = this.path.data(this.links);
    // update existing links
    this.path.classed('selected', (d) => d === this.selectedLink)
      .style('marker-start', (d) => d.left ? 'url(#start-arrow)' : '')
      .style('marker-end', (d) => d.right ? 'url(#end-arrow)' : '');
    // remove old links
    this.path.exit().remove();
    // add new links
    this.path = this.path.enter().append('svg:path')
      .attr('class', 'link')
      .classed('selected', (d) => d === this.selectedLink)
      .style('marker-start', (d) => d.left ? 'url(#start-arrow)' : '')
      .style('marker-end', (d) => d.right ? 'url(#end-arrow)' : '')
      .on('mousedown', (d) => {
        if (d3.event.ctrlKey || !this.editable) return;
        // select link
        this.mousedownLink = d;
        this.selectedLink = (this.mousedownLink === this.selectedLink) ? null : this.mousedownLink;
        this.selectedNode = null;
        console.log('selected link: ', this.selectedLink);
        this.restart();
      })
      .merge(this.path);
    // circle (node) group
    // NB: the function arg is crucial here! nodes are known by id, not by index!
    this.circle = this.circle.data(this.nodes, (d) => d.id);
    // update existing nodes (reflexive & selected visual states)
    this.circle.selectAll('circle')
      .style('fill', (d) => (d === this.selectedNode) ? d3.rgb(this.colors(d.id)).brighter().toString() : this.colors(d.id))
      .classed('reflexive', (d) => d.reflexive);
    // remove old nodes
    this.circle.exit().remove();
    // add new nodes
    const g = this.circle.enter().append('svg:g');
    g.append('svg:circle')
      .attr('class', 'node')
      .attr('r', 20)
      .style('fill', (d) => (d === this.selectedNode) ? d3.rgb(this.colors(d.id)).brighter().toString() : this.colors(d.id))
      .style('stroke', (d) => d3.rgb(this.colors(d.id)).darker().toString())
      // .classed('reflexive', (d) => d.reflexive)
      .on('mouseover', function (d) {
        if (!this.mousedownNode || d === this.mousedownNode) return;
        // enlarge target node
        d3.select(this).attr('transform', 'scale(1.1)');
      })
      .on('mouseout', function (d) {
        if (!this.mousedownNode || d === this.mousedownNode) return;
        // unenlarge target node
        d3.select(this).attr('transform', '');
      })
      .on('mousedown', (d) => {
        if (d3.event.ctrlKey) return;
        // select node
        this.mousedownNode = d;
        this.selectedNode = (this.mousedownNode === this.selectedNode) ? null : this.mousedownNode;
        // this.selectedNode = d;
        this.selectedLink = null;
        // reposition drag line
        this.dragLine
          .style('marker-end', 'url(#end-arrow)')
          .classed('hidden', false)
          .attr('d', `M${this.mousedownNode.x},${this.mousedownNode.y}L${this.mousedownNode.x},${this.mousedownNode.y}`);
        this.restart();
      })
      .on('mouseup', (dataItem: any) => {
        // debugger;
        if (!this.mousedownNode || !this.editable) return;

        // needed by FF
        this.dragLine
          .classed('hidden', true)
          .style('marker-end', '');

        // check for drag-to-self
        this.mouseupNode = dataItem;
        if (this.mouseupNode === this.mousedownNode) {
          this.resetMouseVars();
          return;
        }
        // unenlarge target node
        d3.select(d3.event.currentTarget).attr('transform', '');

        // add link to graph (update if exists)
        // NB: links are strictly source < target; arrows separately specified by booleans
        // const isRight = this.mousedownNode.id < this.mouseupNode.id;
        const link = this.links.filter((l) => l.source === source && l.target === target)[0];
        const source = this.mousedownNode;
        const target = this.mouseupNode;
        if(!this.checkLinkConnection(target.title, source.knowledgeState)){
          target.knowledgeState = target.knowledgeState.concat(source.knowledgeState);
          target.knowledgeState = this.removeDuplicates(target.knowledgeState);
          const _link = { source, target, left: false, right: true };
          this.links.push(_link);
          this.linkService.save(_link).subscribe(response => {
            _link['md5h'] = response['md5h'];
            this.links[this.links.length-1] = _link;
          });
          this.links.forEach(element => {
              console.log(element.source.md5h, target.md5h);
              if (element.source.md5h === target.md5h) {
                console.log(element.target);
                element.target.knowledgeState = element.target.knowledgeState.concat(element.source.knowledgeState);
                element.target.knowledgeState = this.removeDuplicates(element.target.knowledgeState);
                this.updateNode(element.target);
              }
          });
          this.updateNode(source);
          this.updateNode(target);
        }
        // select new link
        this.selectedLink = link;
        this.selectedNode = null;
        this.restart();
      });
    // show node IDs
    g.append('svg:text')
      .attr('x', 0)
      .attr('y', 4)
      .attr('class', 'id')
      .text((d) => d.title);
    this.circle = g.merge(this.circle);

    // set the graph in motion
    this.force
      .nodes(this.nodes)
      .force('link').links(this.links);

    this.force.alphaTarget(0.00001).restart();
  }

  mousedown(dataItem: any, value: any, source: any) {
    // because :active only works in WebKit?
    this.svg.classed('active', true);
    if (d3.event.ctrlKey || this.mousedownNode || this.mousedownLink || !this.editable) return;

    // insert new node at point
    const point = d3.mouse(d3.event.currentTarget);
    // const point = d3.mouse(this);
    const node = { id: ++this.lastNodeId, 
                   reflexive: false, 
                   x: point[0], y: point[1], 
                   title: "node",
                   credibility: 100,
                   probability: 0.0, 
                   domain: { id: this.data['domain']['id']},
                   knowledgeState: []};
    node.knowledgeState.push(node.title);
    this.nodes.push(node);
    this.problemService.save(node).subscribe(response => {
      this.nodes[this.nodes.length-1]['md5h'] = response['md5h'];
      this.loadAndUpdateProblems(this.data['domain']['id']);
    });
    this.restart();
  }

  mousemove(source: any) {
    if (!this.mousedownNode) return;
    // update drag line
    this.dragLine.attr('d', `M${this.mousedownNode.x},${this.mousedownNode.y}L${d3.mouse(d3.event.currentTarget)[0]},${d3.mouse(d3.event.currentTarget)[1]}`);
    this.restart();
  }

  mouseup(source: any) {
    if (this.mousedownNode) {
      // hide drag line
      this.dragLine
        .classed('hidden', true)
        .style('marker-end', '');
    }

    // because :active only works in WebKit?
    this.svg.classed('active', false);

    // clear mouse event vars
    this.resetMouseVars();
  }

  spliceLinksForNode(node) {
    const toSplice = this.links.filter((l) => l.source === node || l.target === node);
    for (const l of toSplice) {
      this.links.splice(this.links.indexOf(l), 1);
    }
  }

  public keydown(event) {
    if(this.titleInputFocus || !this.editable) {return;}
    // console.log("\tLast key Down: ", this.lastKeyDown);
    d3.event.preventDefault();
    // if (this.lastKeyDown !== -1) return;
    this.lastKeyDown = d3.event.keyCode;
    // ctrl
    if (d3.event.keyCode === 17) {
      console.log("\tCTRL pressed!");
      // this.circle.call(this.drag);
      // this.svg.classed('ctrl', true);
    }
    // if (!this.selectedNode && !this.selectedLink) return;
    switch (d3.event.keyCode) {
      case 8: // backspace
      case 46: // delete
        if (this.selectedNode) {
          this.nodes.splice(this.nodes.indexOf(this.selectedNode), 1);
          this.spliceLinksForNode(this.selectedNode);
          this.problemService.delete(this.selectedNode.md5h).subscribe(response => {
            console.log('Problem successfully deleted! ', this.selectedNode);
            this.deleteLinksWithoutNode(response['md5h']);
            this.loadAndUpdateProblems(this.data['domain']['id']);
          });
        } else if (this.selectedLink) {
          console.log('delete selected link: ', this.selectedLink);
          // remove deleted (source) nodes from target node
          var targetNodeIndex = this.nodes.findIndex(item => item.md5h === this.selectedLink.target.md5h);
          this.selectedLink.source.knowledgeState.forEach(element => {
            this.nodes[targetNodeIndex].knowledgeState.splice(this.selectedLink.target.knowledgeState.indexOf(element), 1);
          });
          this.updateNode(this.nodes[targetNodeIndex]);  
          this.links.splice(this.links.indexOf(this.selectedLink), 1);
          this.linkService.delete(this.selectedLink.md5h).subscribe(response => {
            console.log("Link successfully deleted!");
          });
        }
        this.selectedLink = null;
        this.selectedNode = null;
        this.restart();
        break;
      case 66: // B
        if (this.selectedLink) {
          // set link direction to both left and right
          this.selectedLink.left = true;
          this.selectedLink.right = true;
        }
        this.restart();
        break;
      case 76: // L
        if (this.selectedLink) {
          // set link direction to left only
          this.selectedLink.left = true;
          this.selectedLink.right = false;
        }
        this.restart();
        break;
      case 82: // R
        if (this.selectedNode) {
          // toggle node reflexivity
          this.selectedNode.reflexive = !this.selectedNode.reflexive;
        } else if (this.selectedLink) {
          // set link direction to right only
          this.selectedLink.left = false;
          this.selectedLink.right = true;
        }
        this.restart();
        break;
    }
  }

  keyup() {
    this.lastKeyDown = -1;
    // ctrl
    // if (d3.event.keyCode === 17) {
    //   this.circle.on('.drag', null);
    //   this.svg.classed('ctrl', false);
    // }
  }


  updateLinkNodes(){
    this.links.forEach(element => {
      this.checkNode(element['source']);
      this.checkNode(element['target']);
    });
  }

  checkNode(linkNode){
    for(var node in this.nodes) {
      if(this.nodes[node]['id'] === linkNode.id){
        linkNode.x = this.nodes[node]['x']
        linkNode.y = this.nodes[node]['y']
        linkNode.vx = this.nodes[node]['vx']
        linkNode.vy = this.nodes[node]['vy']
      }
    }
  }

  deleteLinksWithoutNode(nodeId: string){
    this.linkService.deleteLinksByProblemId(nodeId).subscribe(response => {
      console.log("Links successfully deleted: ", response);
    });
  }

  public onFocus(){
    this.titleInputFocus = true;
  }

  public confirm(){
    this.selectedNode.knowledgeState[0] = this.selectedNode.title;
    this.problemService.update(this.selectedNode).subscribe(response => {
      // update text of node
      this.circle.select("text")
        .text(function(d) { return d.title; })
        .style("fill-opacity", 1);
      this.nodes[this.nodes.indexOf(this.selectedNode)].title = response['title'];
      this.nodes[this.nodes.indexOf(this.selectedNode)].knowledgeState[0] = response['title'];
      this.titleInputFocus = false;
      this.selectedNode = null;
    });
  }

  updateNode(node){
    this.problemService.update(node).subscribe(response => {
      console.log("Node updated: ", response);
    });
  }

  back(){
    this._location.back();
  }

  removeDuplicates(array){
    return array.filter((a, b) => array.indexOf(a) == b);
  }

  checkLinkConnection(sourceTitle, targetKnowledgeList){
    for(let title in targetKnowledgeList){
      if(targetKnowledgeList[title] === sourceTitle){
        return true;
      }
    }
    return false;
  }

  loadAndUpdateProblems(domainId: string){
    this.problemService.getProblemsByDomainId(domainId).subscribe((problems: any) => {
      problems.forEach(element => {
        this.nodes[this.nodes.findIndex(item => item.md5h == element.md5h)].probability = element.probability;
        this.nodes[this.nodes.findIndex(item => item.md5h == element.md5h)].credibility = element.credibility;
      });
    });
  }

  updateKS(object) {
    this.editable = false;
    this.selectedKs = object.ks;
    switch(this.selectedKs){
      case "default":
        this.realKsService.getDefaultKnowledgeSpaceByTestId(this.testId).subscribe((response: any) => {
          this.nodes = response['problems'];
          this.links = response['links'];
          this.graphSimilarityPercent = null;
          this.restart();
        });
        break;
      case "real":
        this.realKsService.getRealKnowledgeSpaceByTestId(this.testId).subscribe((response: any) => {
          this.nodes = response['problems'];
          this.links = response['links'];
          this.graphSimilarityPercent = null;
          this.restart();
        });
        break;
      case "compared":
        this.comparedKsService.getComparedGraphByTestId(this.testId).subscribe((response: any) => {
          this.nodes = response['problems'];
          this.links = response['links'];
          this.graphSimilarityPercent = response['graphSimilarityPercent'];
          this.restart();
        });
        break;
      default:
        this.nodes = [];
        this.links = [];
        this.graphSimilarityPercent = null;
    }
  }

}
