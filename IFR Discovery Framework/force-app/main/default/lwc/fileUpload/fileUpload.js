import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import processDocument from '@salesforce/apex/ProcessDocument.processDocument';

import extractDocument from '@salesforce/apex/ProcessDocument.extractDocument';
export default class FileUpload extends LightningElement {
    @api recordId
    fileData
    contentDocumentId
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
        console.log('clicked');
        console.log(this.contentDocumentId,'Hello');
        extractDocument(this.contentDocumentId).then(res=>console.log(res)).catch(e=>console.log(e));
    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title, 
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }
}