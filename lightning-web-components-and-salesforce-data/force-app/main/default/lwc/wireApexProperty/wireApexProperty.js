import { LightningElement, api, wire } from "lwc";
import getRelatedContacts from "@salesforce/apex/AccountController.getRelatedContacts";

export default class WireApexProperty extends LightningElement {
  @api recordId;
  @wire(getRelatedContacts, { accountId: "$recordId" })
  contacts;
}
