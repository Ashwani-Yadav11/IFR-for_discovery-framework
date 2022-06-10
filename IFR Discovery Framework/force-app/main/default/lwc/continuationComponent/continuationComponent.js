import { LightningElement, wire } from "lwc";

import startRequest from "@salesforce/apexContinuation/ContinuationController.startRequest";

export default class ContinuationComponent extends LightningElement {
  @wire(startRequest)
  records({ data, error }) {
    console.log(data);
    console.log(error);
  }
}
