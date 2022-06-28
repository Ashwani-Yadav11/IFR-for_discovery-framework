import { LightningElement, api ,wire, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import fileUploadBackground from '@salesforce/resourceUrl/fileUploadBackground';
import processDocument from '@salesforce/apex/ProcessDocument.processDocument';

import extractDocument from '@salesforce/apex/ProcessDocument.extractDocument';


import startExtract from '@salesforce/apex/ApiHandler.startExtract';
export default class FileUpload extends LightningElement {
    @api recordId
    fileData
    contentDocumentId = '';
    @wire(extractDocument,{contentDocumentId: '$contentDocumentId'})
    odsrIds
    contentIds='';
    backgroundImage = fileUploadBackground;
    // @wire(startExtract,{contentDocumentId: '$contentDocumentId',accessToken:'$accessToken.data'})
    // queryResponse
    openfileUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'filename': file.name,
                'base64': base64,
                'recordId': this.recordId
            }
            console.log(this.fileData)
        }
        reader.readAsDataURL(file)
    }
    
    handleClick(){
        const {base64, filename, recordId} = this.fileData
        //startExtract({base64,filename}).then(result=>console.log(result));
        
        processDocument({ base64, filename, recordId }).then(result=>{
            console.log(result);
            this.contentIds=result;
             var ids = result.split(" ");
             console.log(ids);
            this.contentDocumentId = ids[1]; 
            this.handleContentDocumentId();
            this.fileData = null
            let title = `${filename} is uploaded and queued for extraction, please continue with your other work completion of same will be notified via mail !! `
            this.toast(title)
            
        }).catch(e=>{
            console.log(e)
        })
    }
    handleExtract(){
        refreshApex(this.odsrIds);
        console.log(this.sessionId);
        //console.log(this.accessToken,'jii');
        console.log(this.odsrIds,'Hell');
        // if(this.odsrIds.data.ocrDocumentScanResultInfos!=null)
        // this.handleOdsrs();
        console.log('clicked');
        console.log(this.contentDocumentId,'Hello');
        console.log(typeof this.contentDocumentId,'Hi');
       // startExtract('','').then(res=>console.log(res)).catch(e=>console.log(e));
        //extractDocument(String(this.contentDocumentId)).then(res=>console.log(res)).catch(e=>console.log(e));
        
    }

    handleContentDocumentId()
    {
        let message={
            'contentDocumentId':this.contentDocumentId
        }
       
        const selectEvent = new CustomEvent('customevent',{detail:this.contentIds});
        this.dispatchEvent(selectEvent);

    }
    handleOdsrs()
    {
        const selectEvent = new CustomEvent('customevent2',{detail:this.odsrIds.data.ocrDocumentScanResultInfos[0].ocrDocumentScanResultId});
        this.dispatchEvent(selectEvent);
    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title, 
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }
}