import { LightningElement, wire } from "lwc";
import getAccountList from "@salesforce/apex/AccountController.getAccountList";

export default class WireApex extends LightningElement {
  accounts;
  error;

  @wire(getAccountList)
  wiredAccounts({ error, data }) {
    if (data) {
      this.accounts = data;
      this.error = undefined;
    } else {
      this.error = error;
      this.accounts = undefined;
    }
  }
}
