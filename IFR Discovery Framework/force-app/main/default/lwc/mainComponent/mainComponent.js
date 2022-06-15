import { LightningElement,track } from 'lwc';

export default class MainComponent extends LightningElement {
    fileUploaded=false;
     contentId;
    @track contentDocumentId;
    @track contentVersionId;
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
    
}