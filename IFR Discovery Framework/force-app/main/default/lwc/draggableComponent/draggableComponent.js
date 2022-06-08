import { LightningElement,wire } from 'lwc';
//import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class Draggercomponent extends LightningElement {
    //@wire(getAccounts) accounts;
    accounts={
        data:[
            {
                Name:'Abhishek',
                id:'1',
                
            },
            {
                Name:'Ashwani',
                id:'2',
                
            }
        ]
    };
    handleDragStart(event){
        event.dataTransfer.setData("account_id",event.target.dataset.accountid);
    }
}