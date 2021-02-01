import { LightningElement, api } from "lwc";
import getRelatedContacts from "@salesforce/apex/AccountController.getRelatedContacts";

export default class CallApexInperative extends LightningElement {
  @api recordId;

  async handleButtonClick() {
    try {
      const contacts = await getRelatedContacts({
        accountId: "$recordId"
      });
      console.log(contacts);
    } catch (err) {
      console.err(err);
    }
  }
}
