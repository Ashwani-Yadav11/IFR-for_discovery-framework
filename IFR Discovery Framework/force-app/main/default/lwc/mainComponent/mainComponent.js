import { LightningElement,track } from 'lwc';

export default class MainComponent extends LightningElement {
    fileUploaded=false;
    @track contentDocumentId;
    handleCustomEvent(event)
    {
        this.contentDocumentId = event.detail;
        console.log(event.detail,'maincomp');
        this.fileUploaded = true;
    }
    
}