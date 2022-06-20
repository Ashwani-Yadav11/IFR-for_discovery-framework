import { LightningElement,api,wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import filePreview from '@salesforce/apex/ApiHandler.filePreview';
//import renditionStart from '@salesforce/apex/ApiHandler.renditionStart';

export default class PageViewer extends NavigationMixin(LightningElement)  {
    @api contentVersionId='';
  contentDocumentId='069RM0000001h5PYAQ';
    @api heightInRem='';
    //contentDocumentId='069RM0000001hmjYAA';
    @api fileId='';
    get pdfHeight() {
        return 'height: ' + this.heightInRem + 'rem';
    }
    recordPageUrl;
    get url() {
        return '/sfc/servlet.shepherd/version/renditionDownload?rendition=JPGZ&versionId='+this.contentVersionId;
    }
    @wire(filePreview,{contentDocumentId:'$contentDocumentId'})
    texts(data,error){
        console.log(data,'Preview Response');
        console.log(error,'Error');
    }
    
    // connectedCallback() {
    //     // Generate a URL to a User record page
    //     this[NavigationMixin.GenerateUrl]({
    //         type: 'standard__recordPage',
    //         attributes: {
    //             recordId: this.contentDocumentId,
    //             actionName: 'view',
    //         },
    //     }).then((url) => {
    //         console.log(url);
    //         this.recordPageUrl = url;
    //     }).catch(err=>console.log(err));
    // }

}
