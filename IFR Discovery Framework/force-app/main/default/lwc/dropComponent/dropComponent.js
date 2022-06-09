import { LightningElement} from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY from '@salesforce/schema/Account.Industry';
import PHONE from '@salesforce/schema/Account.Phone';
export default class Dropcomponent extends LightningElement {
    accountid;
    fields=[NAME_FIELD,INDUSTRY,PHONE];
    fields2=[NAME_FIELD];
    message='Drop an Account here';
    name;
    dropElelment(event){
        this.accountid = event.dataTransfer.getData("account_id");       
        this.message='';
    }
    dropElelment2(event)
    {
        this.name = event.dataTransfer.getData("account_id");
    }
    allowDrop(event){
        event.preventDefault();
    }
}