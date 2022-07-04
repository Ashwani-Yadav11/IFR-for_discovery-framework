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
                let yCord = keyValue[j].key.polygon[0].yCoordinate;
                let xCord = keyValue[j].key.polygon[0].xCoordinate;
                if(uniqueText.includes(tex)){
                    continue;
                }
                let packet = {
                    text:tex,
                    id:this.listOfTexts.length+1,
                    yCoordinate:yCord,
                    xCoordinate:xCord,
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
            yCoordinate: 0.20748403668403625,
            xCoordinate: 0.15364843606948853,
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
                return text1.yCoordinate == text2.yCoordinate ? text1.xCoordinate - text2.xCoordinate : text1.yCoordinate - text2.yCoordinate;
                 });
              }
              if(!this.isSelected){
                  this.listOfTexts.sort((text1, text2) => {
                return text1.xCoordinate == text2.xCoordinate ? -text2.yCoordinate+text1.yCoordinate : -(text2.xCoordinate - text1.xCoordinate);
                   });
              }
           };
  
    handleDragStart2(e)
    {
        e.dataTransfer.setData("account_id",e.target.dataset.textitem);
        console.log(e.target.dataset.textitem+' dragged');
    }


    
    createTemplate2(e){
        console.log('A question template with '+e.target.dataset.textitem+' as Question Text field will be created');

    }
}