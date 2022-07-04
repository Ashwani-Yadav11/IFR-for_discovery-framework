// //------------------------------------------------------------------------------
// //======================= imports =================================
// //------------------------------------------------------------------------------
import fetchExtractedTexts from '@salesforce/apex/GetExtractedData.fetchExtractedTexts';
import {
    LightningElement,
    wire,
    api,
    track
} from 'lwc';

export default class Draggercomponent extends LightningElement {

    // //------------------------------------------------------------------------------
    // //======================= Variables for component =================================
    // //------------------------------------------------------------------------------

    //Accessing contentDocumentId to get the extracted texts
    @api contentDocumentId;
    //Trackable list of text and necessary parameters
    @track listOfTexts = [];
    //variable to access the current state of list
    isSelected = false;

    //wiring the listOfTexts to fetchExtractedTexts function in order to recieve extracted data from the document
    @wire(fetchExtractedTexts, {
        contentDocumentId: '$contentDocumentId'
    })

    texts({
        data,
        error
    }) {

        //processing the recieved data to obtain the text value and co-ordinates from the nested JSON
        if (data) {
            //keeping a map of recieved values so far in order to avoid duplicates
            let pages = data.ocrDocumentScanResults;
            let uniqueText = [];
            for (let i = 0; i < pages.length; i++) {
                let keyValue = [];
                keyValue = pages[i].keyValuePairs;

                for (let j = 0; j < keyValue.length; j++) {
                    let extractedText = keyValue[j].key.text;
                    let yCord = keyValue[j].key.polygon[0].yCoordinate;
                    let xCord = keyValue[j].key.polygon[0].xCoordinate;

                    //Duplicate text found
                    if (uniqueText.includes(textExtracted)) {
                        continue;
                    }

                    //Creating a Text unit with necessaary params which will required for processing
                    let textPacket = {
                        text: extractedText,
                        id: this.listOfTexts.length + 1,
                        yCoordinate: yCord,
                        xCoordinate: xCord,
                    };
                    uniqueText.push(extractedText);
                    this.listOfTexts.push(textPacket);
                }
            }
        }
    }

    // //------------------------------------------------------------------------------
    // //======================= Methods of component =================================
    // //------------------------------------------------------------------------------

    /**
     * @method sortTextList : event listener to handle the sorting function based on the 
     * co-ordinates and current state of the list(ascending/descending).
     * @param {event} event : Event notifying that the sort button is accessed.
     */
    sortTextList(event) {

        //toggle the current state    
        this.isSelected = !this.isSelected;

        //if the button is accessed Odd times sort in Ascending Order
        if (this.isSelected) {

            this.listOfTexts.sort((text1, text2) => {
                return text1.yCoordinate == text2.yCoordinate ? text1.xCoordinate - text2.xCoordinate : text1.yCoordinate - text2.yCoordinate;
            });
        }
        //if the button is accessed Even times sort in Descending Order
        if (!this.isSelected) {
            this.listOfTexts.sort((text1, text2) => {
                return text1.yCoordinate == text2.yCoordinate ? text1.xCoordinate - text2.xCoordinate : -(text1.yCoordinate - text2.yCoordinate);
            });
        }
    };


    /**
     * @method handleDragStart : this is an event listner which is fired at the start of an element drag, 
     * it sets the data text field to a tranfferable value for cathcing purpose of the drop-zones
     * @param {event} event : Event contains the details in form of DOM Object about the dragged text division.
     */
    handleDragStart(event) {
        //Setting dataTranfer field to be accessed by the dropZone
        event.dataTransfer.setData("textValue", event.target.dataset.textitem);
    }

}