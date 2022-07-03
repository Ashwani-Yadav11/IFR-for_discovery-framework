import startRenditionAndExtractText from '@salesforce/apex/ProcessDocument.startRenditionAndExtractText';
import returnExtractedTexts from '@salesforce/apex/GetExtractedData.returnExtractedTexts';

import { LightningElement,wire ,api,track} from 'lwc';
//import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class Draggercomponent extends LightningElement {
    //@wire(getAccounts) accounts;



 //@api contentDocumentId;
  @api contentDocumentId;
 
  @track listOfTexts=[];
  
   @wire(returnExtractedTexts,{contentDocumentId:'$contentDocumentId'})
    texts({data,error}){
   console.log(this.contentDocumentId);
        console.log(data,this.contentDocumentId+' Extracted Text');
        if(data)
        {
            let pages = data.ocrDocumentScanResults;
            let uniqueText=[];
        for(let i = 0;i<pages.length;i++)
        {
            //for
            let keyValue=[];
            keyValue = pages[i].keyValuePairs;
           
            for(let j=0;j<keyValue.length;j++)
            {
                
                let tex = keyValue[j].key.text;
                if(uniqueText.includes(tex)){
                    continue;
                }
                let packet = {
                    text:tex,
                    id:this.listOfTexts.length+1,
                };
               // console.log(packet);
                uniqueText.push(tex);
                this.listOfTexts.push(packet);
               // console.log(tex);
            }
            

        }
        let packet = {
            text:'Gender',
            id:this.listOfTexts.length+1,
        };
        this.listOfTexts.push(packet);
        //console.info(this.listOfTexts);
        //'ListOftexts');
         }
        console.log(error,'Extracted Text Error');
    }
    // @track listOfTexts=[{
    //     text:'Gender',
    //     id:1,
    // },
    // {
    //     text:'Name',
    //     id:2,
    // },
    // {
    //     text:'Name',
    //     id:3,
    // }];
   
    selectValue = '';
    isSelected = false;
    sortOrder(event) {
      console.log('seleted');
      this.isSelected = !this.isSelected;
         
        if (this.isSelected){
            
               this.listOfTexts.sort((text1, text2) => {
                let compareText1=text1.text.toLowerCase();
                let compareText2=text2.text.toLowerCase();
              if (compareText1< compareText2) {
                     return -1;
                 }
                if (compareText1> compareText2) {
                     return 1;
                 }
                 return 0;
                 });
            }
            if(!this.isSelected){
                this.listOfTexts.sort((text1, text2) => {
                 let compareText1=text1.text.toLowerCase();
                 let compareText2=text2.text.toLowerCase();
                 if (compareText1< compareText2) {
                     return 1;
                }
                 if (compareText1> compareText2) {
                     return -1;
                }
                 return 0;
                 });
            }
         };
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