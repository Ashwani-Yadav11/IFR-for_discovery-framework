import { LightningElement, api ,wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

import processDocument from '@salesforce/apex/ProcessDocument.processDocument';

import extractDocument from '@salesforce/apex/ProcessDocument.extractDocument';
import getSession from '@salesforce/apex/ProcessDocument.getSession';

import startExtract from '@salesforce/apex/ApiHandler.startExtract';
export default class FileUpload extends LightningElement {
    @api recordId
    fileData
    contentDocumentId = '';
    @wire(extractDocument,{contentDocumentId: '$contentDocumentId'})
    odsrIds
    @wire(getSession)
    sessionId
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
            this.contentDocumentId = result; 
            this.fileData = null
            let title = `${filename} uploaded successfully!!`
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
        console.log('clicked');
        console.log(this.contentDocumentId,'Hello');
        console.log(typeof this.contentDocumentId,'Hi');
       // startExtract('','').then(res=>console.log(res)).catch(e=>console.log(e));
        //extractDocument(String(this.contentDocumentId)).then(res=>console.log(res)).catch(e=>console.log(e));
        
    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title, 
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }
}