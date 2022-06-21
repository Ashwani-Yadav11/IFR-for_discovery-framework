import startRenditionAndExtractText from '@salesforce/apex/ProcessDocument.startRenditionAndExtractText';
import returnExtractedTexts from '@salesforce/apex/GetExtractedData.returnExtractedTexts';

import { LightningElement,wire ,api} from 'lwc';
//import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class Draggercomponent extends LightningElement {
    //@wire(getAccounts) accounts;
 //   @api contentDocumentId='069RM0000001hyBYAQ';
 contentDocumentId='069RM0000001hyBYAQ';

    @wire(returnExtractedTexts,{contentDocumentId:'$contentDocumentId'})
    texts(data,error){
        console.log(data,'Extracted Text');
        console.log(error,'Extracted Text Error');
    }

    
    
   
    accounts={
        data:[
            {
                Name:'Name',
                id:'1',
                
            },
            {
                Name:'Gender',
                id:'2',
                
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