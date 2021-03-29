import { LightningElement, api } from "lwc";

export default class DisplayPanel extends LightningElement {
  @api errors;
  @api notes;
  // any other implementation you may want to expose here
}
