import { Component, AfterViewInit, ViewChild, ElementRef } from "@angular/core";

import { NodeEditor, Engine } from "rete";
import ConnectionPlugin  from "rete-connection-plugin";
import ContextMenuPlugin  from "rete-context-menu-plugin";
import { AngularRenderPlugin } from "rete-angular-render-plugin";
import AreaPlugin  from 'rete-area-plugin';
import { NodeComponent } from './components/node.component';


@Component({
  selector: "app-rete",
  template: `
    <div class="wrapper">
      <div #nodeEditor class="node-editor"></div>
    </div>
  `,
  styles: [
    `
      .wrapper {
        width: 100%;
        height: 100%;
      }
      .socket.number {
        background: #96b38a;
      }
    `
  ]
})
export class ReteComponent implements AfterViewInit {
  @ViewChild("nodeEditor") el: ElementRef;
  editor = null;

  async ngAfterViewInit() {
    const container = this.el.nativeElement;

    const components = [new NodeComponent("node")];

    const engine = new Engine("demo@0.2.0");
    const editor = new NodeEditor("demo@0.2.0", container);
    editor.use(ConnectionPlugin);
    editor.use(AngularRenderPlugin);
    editor.use(ContextMenuPlugin);

    components.map(c => {
      editor.register(c);
      engine.register(c);
    });

    const node1 = await components[0].createNode({ data: "proba1" });

    node1.position = [80, 200];

    editor.addNode(node1);

    // editor.connect(node1.outputs.get("parent"), node2.inputs.get("child"));
    // editor.connect(node2.outputs.get("parent"), node3.inputs.get("child"));

    editor.on(
      [
        "process",
        "nodecreated",
        "noderemoved",
        "connectioncreated",
        "connectionremoved"
      ],
      (async () => {
        await engine.abort();
        await engine.process(editor.toJSON());
      }) as any
    );

    editor.view.resize();
    editor.trigger("process");
    AreaPlugin.zoomAt(editor);

    const data = editor.toJSON();
    console.log('Editor data: ', data);
  }
}
