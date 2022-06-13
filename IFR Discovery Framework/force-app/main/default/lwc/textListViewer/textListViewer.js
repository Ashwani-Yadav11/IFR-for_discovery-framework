import { LightningElement,wire,api,track } from 'lwc';
import { refreshApex } from '@salesforce/apex';

import startRequest from "@salesforce/apexContinuation/ContinuationController.startRequest";

import filePreview from "@salesforce/apexContinuation/ContinuationController.filePreview";

import extractDocument from '@salesforce/apex/ProcessDocument.extractDocument';


import renditionStart from '@salesforce/apex/ApiHandler.renditionStart';
import getExtract from "@salesforce/apexContinuation/ContinuationController.getExtract";
export default class TextListViewer extends LightningElement {
//   @api contentDocumentId;

//   contId = this.contentDocumentId;
  contentDocumentId_;
  @api
  get contentDocumentId(){
      return this.contentDocumentId_;
  }
  set contentDocumentId(val)
  {
      this.contentDocumentId_ = val;
  }
  listOfRecords;
  //contentDocumentId='069RM0000001hSPYAY';
    // @wire(filePreview,{contentDocumentId:'$contentDocumentId_'})
    // files({data,error}){
    //     console.log(this.contentDocumentId_);
    //     console.log(data,'File Preview One');
    //     console.log(error);
    // }
    @wire(renditionStart,{contentDocumentId:'$contentDocumentId_'})
    files({data,error})
    {
        console.log(data,'OdsrIds New');
        console.log(error,'new error');
    }
    // @wire(extractDocument,{contentDocumentId: '$contentDocumentId_'})
    // odsrIds({data,error})
    // {
    //     console.log(this.contentDocumentId_);
    //     console.log(data,'OdsrIds');
    //     if(data)
    //     {
    //         if(data.status.code!='UNPROCESSABLE_ENTITY')
    //         this.listOfRecords=data.ocrDocumentScanResultInfos;
    //     }
    //     console.log(error);
    // }
    // @track listOfRecords;
    // @track error;
    // connectedCallback() {
    // filePreview(String(this.contentDocumentId))
    //            .then(result => {
    // this.listOfRecords = result;
    // console.log(this.contentDocumentId,'TextList Success');
    // console.log(this.listOfRecords);
    // this.error = undefined;
    //            })
    //            .catch(error => {
    // this.error = error;
    // console.log(this.contentDocumentId,'TextList Error');

    // this.listOfRecords = undefined;
    // console.log(error);
    //            });
    //    }
    
    // handleRefresh()
    // {
    //     console.log(this.contentDocumentId);
    //     refreshApex(this.odsrIds);
    //     console.log(this.listOfRecords);
        
    // }
}