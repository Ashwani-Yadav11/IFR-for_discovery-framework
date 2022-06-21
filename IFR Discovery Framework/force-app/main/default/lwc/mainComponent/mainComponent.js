import returnExtractionStatus from '@salesforce/apex/GetExtractedData.returnExtractionStatus';
import { LightningElement,track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';

export default class MainComponent extends LightningElement {
    fileUploaded=false;
     contentId;
    spinner=false;
    @track success=false;
    @track error;
    @track contentDocumentId='';
    @track contentVersionId;
    maxattempts = 4;
    attempt = 0;
    // @wire(returnExtractionStatus,{contentDocumentId:'$contentDocumentId'})
    // successStatus({data,error}){
    //     if(data==true)
    //     {
    //         this.success = true;
    //         this.spinner=false;
    //     }
    //     console.log(data);
    //     console.log(error) ;
    //     console.log(this.success,'SuccessStatus');
    // }
    handleCustomEvent(event)
    {
        this.contentId = event.detail;
        var ids = this.contentId.split(" ");
             console.log(ids);
            this.contentDocumentId = ids[1]; 
            this.contentVersionId = ids[0];
        console.log(event.detail,'maincomp');
        this.fileUploaded = true;
        this.spinner=true;
      //  this.checkExtractionStatus();
    }
    handleExtract(){
        this.success = true;
    }
    // renderedCallback(){
    //     returnExtractionStatus({contentDocumentId:'$contentDocumentId'}).then(response=>{
    //         console.log(response,'Respose');
    //         this.success = response;
    //      }).catch(error=>{
    //         console.log(error);
    //         this.error = error;
    //      });
    // }
    //  checkExtractionStatus(){
    //     this.attempt++;
    //     console.log('Method called');
    //     returnExtractionStatus({contentDocumentId:'$contentDocumentId'}).then(response=>{
    //         console.log(response,'Respose');
    //      }).catch(error=>{
    //         console.log(error);
    //         if(this.attempt<this.maxattempts)
    //         {
    //             renderedCallback() {
    //             if(!this.ready)
    //             this.ready == true;
    //             } 
    //             setTimeout(this.checkExtractionStatus(),30000);
    //         }
    //      });
         
       
    // }

    
}