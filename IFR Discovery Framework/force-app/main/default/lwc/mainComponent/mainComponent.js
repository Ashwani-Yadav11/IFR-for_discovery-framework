import returnExtractionStatus from '@salesforce/apex/GetExtractedData.returnExtractionStatus';
import { LightningElement,track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';

export default class MainComponent extends LightningElement {
    fileUploaded=false;
     contentId;
    spinner=false;
    success=false;
    
    @track contentDocumentId='';
    @track contentVersionId;
    @wire(returnExtractionStatus,{contentDocumentId:'$contentDocumentId'})
    successStatus(data,error){
        if(data==true)
        {
            this.success = true;
            this.spinner=false;
        }
        console.log(data);
        console.log(error) ;
        console.log(this.successStatus,'SuccessStatus');
    }
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
        checkExtractionStatus();
    }
    checkExtractionStatus(){
        setInterval(refreshApex(this.successStatus),5000);
    }

    
}