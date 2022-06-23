import returnExtractionStatus from '@salesforce/apex/GetExtractedData.returnExtractionStatus';
import { LightningElement,track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import {CurrentPageReference} from 'lightning/navigation';
import returnExtractedTexts from '@salesforce/apex/GetExtractedData.returnExtractedTexts';

export default class MainComponent extends LightningElement {
    fileUploaded=false;
     contentId;
    @track spinner=false;
    @track success=false;
    @track error;
    @track contentDocumentId='';
    @track contentVersionId;
    //@track list
    currentPageReference = null; 
    urlStateParameters = null;
 
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        console.log(currentPageReference,'Current Page reference');
       if (currentPageReference) {
     
          this.urlStateParameters = currentPageReference.state;
          this.setParametersBasedOnUrl();
       }
    }
 
    setParametersBasedOnUrl() {
       this.contentDocumentId = this.urlStateParameters.c__contentDocumentId || null;
        if(this.contentDocumentId!=null)
        {   this.fileUploaded=true;
            this.success = true;}
        console.log(this.contentDocumentId,this.success,'Content Id fetched from url');
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

    }
    handleExtract(e){
        //e.preventDefault();
        this.spinner = true;
        returnExtractionStatus({contentDocumentId:this.contentDocumentId}).then(response=>{
            this.spinner = false;
                    console.log(response,response.length,'Respose');
                    if(response.length==0)
                    {
                        alert("Extraction in progress.Please wait or check email for confirmation");
                        this.success = false;
                    }
                    else
                   this.success = true;
                
                 }).catch(error=>{
                    this.spinner = false;
                    console.log(error);
                    this.error = error;
                    alert("Extraction in progress.Please wait or check email for confirmation");
                    
                 });  
    }

    
}