import { Component, ViewChild, ElementRef, AfterViewInit, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import * as d3 from 'd3';
import { ProblemService } from 'src/app/domain/services/problem.service';
import { LinkService } from 'src/app/domain/services/link.service';

@Component({
  selector: 'app-d3',
  templateUrl: './d3.component.html',
  styleUrls: ['./d3.component.css']
})
export class D3Component implements AfterViewInit, OnInit {

  title = 'ng-d3-graph-editor';
  @ViewChild('graphContainer') graphContainer: ElementRef;

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
  public domain: any;

  constructor(
    private route: ActivatedRoute,
    private problemService: ProblemService,
    private linkService: LinkService
  ) {}

  ngOnInit(){
    this.domain = this.route.snapshot.data["data"];
    this.nodes = this.domain['domain'][0]['problems'];
    this.links = this.domain['domain'][0]['links'];
    this.lastNodeId = this.nodes.length;
  }

  ngAfterViewInit() {
    console.log('nodes: ', this.nodes);
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
        d.fx = d.x;
        d.fy = d.y;
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
    // console.log("-- Restart");
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
        if (d3.event.ctrlKey) return;
        // select link
        this.mousedownLink = d;
        this.selectedLink = (this.mousedownLink === this.selectedLink) ? null : this.mousedownLink;
        this.selectedNode = null;
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
        console.log('\tSelected Node setted: ', this.selectedNode);
        

        // debugger;
        if (!this.mousedownNode) return;

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
        console.log('\tMouse Up Node: ', this.mouseupNode);
        // unenlarge target node
        d3.select(d3.event.currentTarget).attr('transform', '');

        // add link to graph (update if exists)
        // NB: links are strictly source < target; arrows separately specified by booleans
        // const isRight = this.mousedownNode.id < this.mouseupNode.id;
        const source = this.mousedownNode;
        const target = this.mouseupNode;
        const link = this.links.filter((l) => l.source === source && l.target === target)[0];
        if (link) {
          // link[isRight ? 'right' : 'left'] = true;
          link['right'] = true;
        } else {
          console.log('source: ', source.title, " target: ", target.title);
          console.log('source order: ', source.order, " target order: ", target.order);
          if(source.order <= target.order || (source.order > target.order && target.order === 0)) {
            if(source.order === 0) {
              source.order += 1;
            }
            target.order += source.order + 1;
            const _link = { source, target, left: false, right: true };
            this.links.push(_link);
            this.linkService.save(_link).subscribe(response => {
              _link['md5h'] = response['md5h'];
              this.links[this.links.length-1] = _link;
              console.log('Link successfully saved: ', _link);
            });
            this.updateNode(source);
            this.updateNode(target);
          }
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

    this.force.alphaTarget(0.3).restart();
  }

  mousedown(dataItem: any, value: any, source: any) {
    // because :active only works in WebKit?
    this.svg.classed('active', true);

    if (d3.event.ctrlKey || this.mousedownNode || this.mousedownLink) return;

    // insert new node at point
    const point = d3.mouse(d3.event.currentTarget);
    // const point = d3.mouse(this);
    const node = { id: ++this.lastNodeId, reflexive: false, x: point[0], y: point[1], title: "title", order: 0 };
    console.log('new node: ', node);
    this.nodes.push(node);
    this.problemService.save(node).subscribe(response => {
      this.nodes[this.nodes.length-1]['md5h'] = response['md5h'];
      console.log('Problem succesfully saved: ', node);
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
    console.log('Key Down: ', d3.event.keyCode);
    console.log("\tSelected node: ", this.selectedNode);
    console.log("\ttitleInputFocus node: ", this.titleInputFocus);
    console.log("\tastKeyDown: ", this.lastKeyDown);
    if(this.titleInputFocus) {return;}
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
    console.log('\tselected node: ', this.selectedNode);
    console.log('\tselected link: ', this.selectedLink);
    // if (!this.selectedNode && !this.selectedLink) return;
    switch (d3.event.keyCode) {
      case 8: // backspace
      case 46: // delete
        console.log('\tdelete case');
        if (this.selectedNode) {
          this.nodes.splice(this.nodes.indexOf(this.selectedNode), 1);
          this.spliceLinksForNode(this.selectedNode);
          this.problemService.delete(this.selectedNode.md5h).subscribe(response => {
            console.log('Problem successfully deleted! ', this.selectedNode);
            this.deleteLinksWithoutNode(response['md5h']);
          });
        } else if (this.selectedLink) {
          console.log('target order: ', this.selectedLink.target.order, ' source order: ', this.selectedLink.source.order);
          if (this.selectedLink.source.order > this.selectedLink.target.order){
            this.nodes[this.nodes.indexOf(this.selectedLink.target)].order = 0;
          } else {
            this.nodes[this.nodes.indexOf(this.selectedLink.target)].order -= this.selectedLink.source.order;
          }
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
    console.log('Key Up: ', d3.event.keyCode);
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

  public focusout(){
    console.log('selected node: ', this.selectedNode, this.domain);
    this.problemService.update(this.selectedNode).subscribe(response => {
      // update text of node
      this.circle.select("text")
        .text(function(d) { console.log('title: ', d.title); return d.title; })
        .style("fill-opacity", 1);
      this.nodes[this.nodes.indexOf(this.selectedNode)].title = response['title'];
      this.titleInputFocus = false;
      this.selectedNode = null;
    });
  }

  updateNode(node){
    this.problemService.update(node).subscribe(response => {
      console.log("Node updated: ", response);
    });
  }
}
