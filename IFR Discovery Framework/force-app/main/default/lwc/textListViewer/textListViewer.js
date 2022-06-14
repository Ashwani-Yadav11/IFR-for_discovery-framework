import { LightningElement,wire,api,track } from 'lwc';
import { refreshApex } from '@salesforce/apex';

import startRequest from "@salesforce/apexContinuation/ContinuationController.startRequest";

import filePreview from "@salesforce/apexContinuation/ContinuationController.filePreview";

import extractDocument from '@salesforce/apex/ProcessDocument.extractDocument';


import renditionStart from '@salesforce/apex/ApiHandler.renditionStart';
import getExtract from '@salesforce/apex/ApiHandler.getExtract';
import extractedData from '@salesforce/apex/GetExtractedData.extractedData';
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
    odsrId;
    @wire(renditionStart,{contentDocumentId:'$contentDocumentId_'})
    files({data,error})
    {
        console.log(data,'OdsrIds New1');
        if(data)
        {
            this.odsrId = data.ocrDocumentScanResultInfos[0].ocrDocumentScanResultId;
        }
        console.log(error,'new error3');
    }
    // @wire(extractedData,{contentDocumentId:'$contentDocumentId_',odsrId:'$odsrId'})
    // texts
    // @wire(getExtract,{contentDocumentId:'$contentDocumentId_',odsrId:'$odsrId'})
    // texts
    
    // ({data,error})
    // {
    //     console.log(data,'Extract data');
    //     if(data)
    //     this.listOfRecords = data;
    //     console.log(error,'Extract error');
    // }
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
    
    handleRefresh()
    {
        //console.log(this.contentDocumentId);
        refreshApex(this.texts);
        console.log(this.texts);
        //console.log(this.listOfRecords);
        
    }
}