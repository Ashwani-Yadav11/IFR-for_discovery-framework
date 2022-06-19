import { LightningElement,wire } from 'lwc';
//import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class Draggercomponent extends LightningElement {
    //@wire(getAccounts) accounts;
    accounts={
        data:[
            {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },
            {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },
            {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },     {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },     {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },
            {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },
            {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },
            {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },     {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
                
            },     {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
            },
            { Name:'Address',
                id:'3',
                
            },
            { Name:'Account Number',
                id:'3',
        }
        ]
    };
    selectValue = '';
    handleDragStart(e){
        e.dataTransfer.setData("account_id",e.target.dataset.accountname);
      console.log(e.target.dataset.accountname+' dragged');
      
    }

    createTemplate(e){
        
    
        console.log('A question template with '+e.target.dataset.accountname+' as Question Text field will be created');
     
    }
}