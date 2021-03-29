import { api, LightningElement } from "lwc";
import { sum } from "./sum";

export default class UnitTest extends LightningElement {
  @api
  unitNumber = sum(2, 3);

  handleChange(event) {
    // eslint-disable-next-line @lwc/lwc/no-api-reassignments
    this.unitNumber = event.target.value;
  }
}
