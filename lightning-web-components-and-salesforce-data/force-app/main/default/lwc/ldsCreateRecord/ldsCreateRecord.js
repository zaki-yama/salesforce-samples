import { LightningElement } from "lwc";
import { createRecord } from "lightning/uiRecordApi";

import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import ACCOUNT_NAME_FIELD from "@salesforce/schema/Account.Name";

export default class LdsCreateRecord extends LightningElement {
  async handleButtonClick() {
    const recordInput = {
      apiName: ACCOUNT_OBJECT.objectApiName,
      fields: {
        [ACCOUNT_NAME_FIELD.fieldApiName]: "ACME"
      }
    };

    try {
      const account = await createRecord(recordInput);
      console.log(account);
    } catch (err) {
      console.error(err);
    }
  }
}
