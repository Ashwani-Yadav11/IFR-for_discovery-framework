import { LightningElement, api, wire, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";
import fileUploadBackground from "@salesforce/resourceUrl/fileUploadBackground";
import processDocument from "@salesforce/apex/ProcessDocument.processDocument";

import extractDocument from "@salesforce/apex/ProcessDocument.extractDocument";

import startExtract from "@salesforce/apex/ApiHandler.startExtract";
export default class FileUpload extends LightningElement {
  @api recordId;
  fileData;
  contentDocumentId = "";
  @wire(extractDocument, { contentDocumentId: "$contentDocumentId" })
  odsrIds;
  contentIds = "";
  backgroundImage = fileUploadBackground;
  @track openModal = false;
  @track uploaded = false;
  // @wire(startExtract,{contentDocumentId: '$contentDocumentId',accessToken:'$accessToken.data'})
  // queryResponse
  openfileUpload(event) {
    const file = event.target.files[0];
    var reader = new FileReader();
    reader.onload = () => {
      var base64 = reader.result.split(",")[1];
      this.fileData = {
        filename: file.name,
        base64: base64,
        recordId: this.recordId
      };
      console.log(this.fileData);
      this.openModal = true;
      this.handleUpload();
    };
    reader.readAsDataURL(file);
  }

  handleUpload() {
    const { base64, filename, recordId } = this.fileData;
    //startExtract({base64,filename}).then(result=>console.log(result));

    processDocument({ base64, filename, recordId })
      .then((result) => {
        console.log(result);
        this.contentIds = result;
        var ids = result.split(" ");
        console.log(ids);
        this.contentDocumentId = ids[1];

        this.uploaded = true;
        let message =
          "File was uploaded. We’ll notify you via email after extracting the text.";

        const toastEvent = new ShowToastEvent({
          title: "Sucess!",
          variant: "success",
          message: message
        });
        this.dispatchEvent(toastEvent);
      })
      .catch((e) => {
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

  toastSuccess(title) {
    const toastEvent = new ShowToastEvent({
      title,
      variant: "success"
    });
    this.dispatchEvent(toastEvent);
  }
  toastFailure(title) {
    const toastEvent = new ShowToastEvent({
      title,
      variant: "error"
    });
    this.dispatchEvent(toastEvent);
  }
  closeModal(event) {
    this.openModal = false;
    this.fileData = null;
    eval("$A.get('e.force:refreshView').fire();");
  }
}
