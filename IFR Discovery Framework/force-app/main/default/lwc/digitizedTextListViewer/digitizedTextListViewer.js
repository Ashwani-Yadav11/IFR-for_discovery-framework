import startRenditionAndExtractText from '@salesforce/apex/ProcessDocument.startRenditionAndExtractText';
import returnExtractedTexts from '@salesforce/apex/GetExtractedData.returnExtractedTexts';

import { LightningElement,wire ,api,track} from 'lwc';

export default class Draggercomponent extends LightningElement {
 




  @api contentDocumentId;
 
  @track listOfTexts=[];
  
   @wire(returnExtractedTexts,{contentDocumentId:'$contentDocumentId'})
    texts({data,error}){
  
        if(data)
        {
            let pages = data.ocrDocumentScanResults;
            let uniqueText=[];
        for(let i = 0;i<pages.length;i++)
        {
            let keyValue=[];
            keyValue = pages[i].keyValuePairs;
           
            for(let j=0;j<keyValue.length;j++)
            {
                
                let textExtracted = keyValue[j].key.text;
                let yCord = keyValue[j].key.polygon[0].yCoordinate;
                let xCord = keyValue[j].key.polygon[0].xCoordinate;
                if(uniqueText.includes(textExtracted)){
                    continue;
                }
                let packet = {
                    text:textExtracted,
                    id:this.listOfTexts.length+1,
                    yCoordinate:yCord,
                    xCoordinate:xCord,
                };
                uniqueText.push(textExtracted);
                this.listOfTexts.push(packet);
            }
        } 
    }
}
   
    
    isSelected = false;
    sortOrder(event) {
        
        this.isSelected = !this.isSelected;
    
          if (this.isSelected){
                
                 this.listOfTexts.sort((text1, text2) => {
                return text1.yCoordinate == text2.yCoordinate ? text1.xCoordinate - text2.xCoordinate : text1.yCoordinate - text2.yCoordinate;
                 });
              }
        if(!this.isSelected){
                  this.listOfTexts.sort((text1, text2) => {
                return text1.yCoordinate == text2.yCoordinate ? text1.xCoordinate - text2.xCoordinate : -(text1.yCoordinate - text2.yCoordinate);
                   });
              }
        };

    handleDragStart(e){
        e.dataTransfer.setData("textValue",e.target.dataset.textitem);
        console.log(e.target.dataset.textitem+' dragged');
    }

}