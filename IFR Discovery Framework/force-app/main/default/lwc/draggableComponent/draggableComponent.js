import startRenditionAndExtractText from '@salesforce/apex/ProcessDocument.startRenditionAndExtractText';
import returnExtractedTexts from '@salesforce/apex/GetExtractedData.returnExtractedTexts';

import { LightningElement,wire ,api,track} from 'lwc';
//import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class Draggercomponent extends LightningElement {
    //@wire(getAccounts) accounts;



 @api contentDocumentId;
 //contentDocumentId='069RM0000001hyBYAQ';
 
    @track listOfTexts=[];
    @wire(returnExtractedTexts,{contentDocumentId:'$contentDocumentId'})
    texts({data,error}){
   console.log(this.contentDocumentId);
        console.log(data,this.contentDocumentId+' Extracted Text');
        if(data)
        {
            let pages = data.ocrDocumentScanResults;
            let temp ={
                text:'Gender',
                id:1,
            }
            this.listOfTexts.push(temp);
        for(let i = 0;i<pages.length;i++)
        {
            //for
            let keyValue=[];
            keyValue = pages[i].keyValuePairs;
           
            for(let j=0;j<keyValue.length;j++)
            {
                let tex = keyValue[j].key.text;
                let packet = {
                    text:tex,
                    id:this.listOfTexts.length+1,
                };
               // console.log(packet);
                this.listOfTexts.push(packet);
               // console.log(tex);
            }
            

        }
        //console.info(this.listOfTexts);
        //'ListOftexts');
         }
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
    handleDragStart2(e)
    {
        e.dataTransfer.setData("account_id",e.target.dataset.textitem);
        console.log(e.target.dataset.textitem+' dragged');
    }

    createTemplate(e){
        
    
        console.log('A question template with '+e.target.dataset.accountname+' as Question Text field will be created');
     
    }
    createTemplate2(e){
        console.log('A question template with '+e.target.dataset.textitem+' as Question Text field will be created');

    }
}