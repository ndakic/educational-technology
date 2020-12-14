import { Control } from "rete";
import { AngularControl } from "rete-angular-render-plugin";
import { Type } from "@angular/core";
import { NumberNgControl } from "./num.component";

export class NumControl extends Control implements AngularControl {
  component: Type<NumberNgControl>;
  props: { [key: string]: unknown };

  constructor(public emitter, public key, readonly = false) {
    super(key);

    this.component = NumberNgControl;
    this.props = {
      readonly,
      change: v => this.onChange(v),
      value: "",
      mounted: () => {
        this.setValue((this.getData(key) as any) || "");
      }
    };
  }

  onChange(val: string) {
    this.setValue(val);
    this.emitter.trigger("process");
  }

  setValue(val: string) {
    this.props.value = +val;
    this.putData(this.key, this.props.value);
  }
}
