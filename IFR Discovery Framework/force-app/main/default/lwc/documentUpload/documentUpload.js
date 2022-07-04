// //------------------------------------------------------------------------------
// //======================= Imports =================================
// //------------------------------------------------------------------------------

import { LightningElement, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import fileUploadBackground from "@salesforce/resourceUrl/fileUploadBackground";
import processDocument from "@salesforce/apex/DocumentProcessGateway.processDocument";

export default class DocumentUpload extends LightningElement {
  // //------------------------------------------------------------------------------
  // //======================= Variables for component ===========================
  // //------------------------------------------------------------------------------
  @track documentData;
  @track openModal = false;
  @track documentUploaded = false;
  backgroundImage = fileUploadBackground;

  // //------------------------------------------------------------------------------
  // //======================= Methods for component =================================
  // //------------------------------------------------------------------------------

  /**
   * @method preprocessUploadedDocument : This event is fired when a file is uploaded
   *                                      It converts the file into base64 format
   * @param {event} event : Event containing the file details
   */
  preprocessUploadedDocument(event) {
    //Read the file from event
    const file = event.target.files[0];

    var reader = new FileReader();

    reader.onload = () => {
      //Convert the document into base64 notation
      var encodedDocument = reader.result.split(",")[1];

      //Create a documentData packet
      this.documentData = {
        documentName: file.name,
        encodedDocument: encodedDocument
      };
      this.openModal = true;
      this.uploadDocument();
    };
    reader.readAsDataURL(file);
  }
  /**
   * @method uploadDocument : This method calls an Apex class method
   */
  uploadDocument() {
    //Extract the base64 notation and documentName from documentData
    const { encodedDocument, documentName } = this.documentData;

    /**
     * @method processDocument : Apex class method that uploades the document in ContentVersion sObject
     * @param {String} encodedDocument : base64 notation of the document uploaded
     * @param {String} documentName : Name of the document uploaded
     */

    processDocument({ encodedDocument, documentName })
      .then((result) => {
        this.documentUploaded = true;

        let message =
          "File was uploaded. We’ll notify you via email after extracting the text.";

        const toastEvent = new ShowToastEvent({
          title: "Sucess!",
          variant: "success",
          message: message
        });
        this.dispatchEvent(toastEvent);
      })
      .catch((error) => {
        this.closeModal();

        let message =
          "Something went wrong. We couldn’t upload the file. Try again after sometime.";

        const toastEvent = new ShowToastEvent({
          title: "Error!",
          variant: "error",
          message: message
        });
        this.dispatchEvent(toastEvent);
      });
  }
  /**
   * @method closeModal : controls the modalPane that opens when a file is Uploaded
   */
  closeModal(event) {
    //reset the variables
    this.openModal = false;
    this.documentData = null;
  }
}
