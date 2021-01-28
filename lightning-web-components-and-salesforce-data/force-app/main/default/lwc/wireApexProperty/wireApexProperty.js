import { LightningElement, api, wire } from "lwc";
import { reduceErrors } from "c/ldsUtils";
import getRelatedContacts from "@salesforce/apex/AccountController.getRelatedContacts";

export default class WireApexProperty extends LightningElement {
  @api recordId;
  @wire(getRelatedContacts, { accountId: "$recordId" })
  contacts;

  get errors() {
    return this.contacts.error ? reduceErrors(this.contacts.error) : [];
  }
}
