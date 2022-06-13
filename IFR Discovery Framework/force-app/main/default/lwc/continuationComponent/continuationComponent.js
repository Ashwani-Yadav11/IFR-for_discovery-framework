import { LightningElement, wire ,api} from "lwc";
import { refreshApex } from '@salesforce/apex';
import startRequest from "@salesforce/apexContinuation/ContinuationController.startRequest";

import filePreview from "@salesforce/apexContinuation/ContinuationController.filePreview";




import getExtract from "@salesforce/apexContinuation/ContinuationController.getExtract";

export default class ContinuationComponent extends LightningElement {
    @api
    contentDocumentId;
  @wire(startRequest)
  records({ data, error }) {
    console.log(data,'hi');
    console.log(error);
  }
//records = {data:'hello'};
@wire(filePreview,{contentDocumentId:'$contentDocumentId'})
files({data,error}){
  console.log(data,'continuation component');
  console.log(error);
}
    handleRefresh()
    {
        console.log(this.contentDocumentId);
        refreshApex(this.files);
        
    }
//   @wire(startExtract,{contnentDocumentId:'$contentDocumentId'})
//   start({data,error}){
//     console.log(data);
//     console.log(error);
//   }
//   @wire(getExtract,{contentDocumentId:'$contentDocumentId'})
//   result({data,error}){
//     console.log(data,'hello');
//     console.log(error);
//   }

}
