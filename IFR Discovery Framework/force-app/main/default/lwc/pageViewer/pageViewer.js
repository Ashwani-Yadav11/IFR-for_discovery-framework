import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class PageViewer extends NavigationMixin(LightningElement)  {
    @api contentDocumentId='';
    @api heightInRem='';
    //contentDocumentId='069RM0000001hmjYAA';
    get pdfHeight() {
        return 'height: ' + this.heightInRem + 'rem';
    }
    recordPageUrl;
    get url() {
        return '/sfc/servlet.shepherd/version/renditionDownload?rendition=JPGZ&versionId=068RM0000001kDMYAY';
    }
    connectedCallback() {
        // Generate a URL to a User record page
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.contentDocumentId,
                actionName: 'view',
            },
        }).then((url) => {
            console.log(url);
            this.recordPageUrl = url;
        }).catch(err=>console.log(err));
    }

}
