import { LightningElement,api,wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import renditionStart from '@salesforce/apex/ApiHandler.renditionStart';

export default class PageViewer extends NavigationMixin(LightningElement)  {
    @api contentVersionId='';
    @api contentDocumentId='';
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
    @wire(renditionStart,{contentDocumentId:'$contentDocumentId'})
    files({data,error})
    {
        console.log(data,'OdsrIds New1');
        console.log(error,'new error3');
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
