// //------------------------------------------------------------------------------
// //======================= Imports =================================
// //------------------------------------------------------------------------------
import { LightningElement, track, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";

export default class LandingComponent extends LightningElement {
  @track emailSucessRedirection = false;
  @track contentDocumentId = "";
  currentPageReference = null;
  urlStateParameters = null;
  /**
   * @method getStateParameters : this is a wire method to get the url parameter
   * @param {CurrentPageRefernce} currentPageReference
   */
  @wire(CurrentPageReference)
  getStateParameters(currentPageReference) {
    if (currentPageReference) {
      this.urlStateParameters = currentPageReference.state;
      this.setParametersBasedOnUrl();
    }
  }
  /**
   * @method setParametersBasedOnUrl : extracts the contentDocumentId from url
   * url form is ..?c__contentDocumentId=<contentDocumentId> if it is a emailRedirected url
   */
  setParametersBasedOnUrl() {
    this.contentDocumentId =
      this.urlStateParameters.c__contentDocumentId || null;
    if (this.contentDocumentId != null) {
      this.emailSucessRedirection = true;
    }
  }
}
