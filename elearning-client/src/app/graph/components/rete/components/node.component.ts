import { Component, Input, Node, Output } from "rete";
import { numSocket } from "../sockets";
import { NumControl } from "../controls/num-control";

export class NodeComponent extends Component {
  data: any;
  constructor(name: string) {
    super(name);
  }

  async builder(node) {
    const input = new Input("input", "Input", numSocket, true);
    const output = new Output("output", "Output", numSocket, true);
    node
      .addInput(input)
      .addControl(new NumControl(this.editor, "preview", true))
      .addOutput(output);
  }

  worker(node, inputs, outputs) {
    // const n1 = inputs["num1"].length ? inputs["num1"][0] : node.data.num1;
    // const n2 = inputs["num2"].length ? inputs["num2"][0] : node.data.num2;
    // const sum = n1 + n2;

    // const ctrl = this.editor.nodes
    //   .find(n => n.id === node.id)
    //   .controls.get("preview") as NumControl;
    // ctrl.setValue(sum);
    // outputs["num"] = sum;
  }
}
