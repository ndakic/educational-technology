import { Component, Input } from "@angular/core";

@Component({
  template: `
    <input
      type="string"
      [value]="value"
      [readonly]="false"
    />
  `,
  styles: [
    ` input {
        border-radius: 80px;
        background-color: white;
        padding: 2px 6px;
        border: 1px solid #999;
        font-size: 110%;
        width: 140px;
        box-sizing: border-box;
      }
    `
  ]
})
export class NumberNgControl {
  @Input() value: number;
  @Input() readonly: boolean;
  @Input() change: Function;
  @Input() mounted: Function;
  ngOnInit() {
    this.mounted();
  }
}