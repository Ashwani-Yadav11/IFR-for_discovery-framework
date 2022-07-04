
// //------------------------------------------------------------------------------
// //======================= imports =================================
// //------------------------------------------------------------------------------
import fetchExtractedTexts from '@salesforce/apex/GetExtractedData.fetchExtractedTexts';
import { LightningElement,wire ,api,track} from 'lwc';

export default class Draggercomponent extends LightningElement {
  
 //Accessing contentDocumentId to get the extracted texts
    @api contentDocumentId;

  @track listOfTexts=[];

  //wiring the listOfTexts to fetchExtractedTexts function in order to recieve extracted data from the document
   @wire(fetchExtractedTexts,{contentDocumentId:'$contentDocumentId'})

    texts({data,error}){
  
        //processing the recieved data to obtain the text value and co-ordinates from the nested JSON
        if(data)
        {
            //keeping a map of recieved values so far in order to avoid duplicates
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
   
//an event listener to handle the sorting function based on the co-ordinates and current state of the list(ascending/descending)
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

//this is an event listner which is fired at the start of an element drag, it sets the data text field to a tranfferable value
//for cathcing purpose of the drop-zones
    handleDragStart(e){
        e.dataTransfer.setData("textValue",e.target.dataset.textitem);
        console.log(e.target.dataset.textitem+' dragged');
    }

}