import { LightningElement,api } from 'lwc';

export default class PageViewer extends LightningElement {
    @api fileId;
    @api heightInRem;

    get pdfHeight() {
        return 'height: ' + this.heightInRem + 'rem';
    }
    
    get url() {
        return '/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=068RM0000001kDMYAY';
    }
}