import { LightningElement, api } from "lwc";

export default class Button extends LightningElement {
  @api disabled;
  @api iconName;
  @api iconPosition;
  @api label;
  @api name;
  @api type;
  @api value;
  @api variant;
}
