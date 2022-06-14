import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class PageViewer extends NavigationMixin(LightningElement)  {
    @api contentDocumentId='';
    //contentDocumentId='069RM0000001hmjYAA';
    get pdfHeight() {
        return 'height: ' + this.heightInRem + 'rem';
    }
    recordPageUrl;

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