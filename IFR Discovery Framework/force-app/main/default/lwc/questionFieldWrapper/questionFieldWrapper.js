import { LightningElement,track } from 'lwc';

export default class QuestionFieldWrapper extends LightningElement {
    @track questions=[{
            id:1,
        },
    ];
    activeSections = ['1'];

    activeSectionMessage = '';
   // isDVisible = false;
    addNewQuestion(event){
        this.questions.push({id:this.questions.length+1});
        this.activeSections.push(String(this.questions.length+1));
           
    }
    handleSectionToggle(event) {
        const openSections = event.detail.openSections;

        if (openSections.length === 0) {
            this.activeSectionsMessage = 'All sections are closed';
        } else {
            this.activeSectionsMessage =
                'Open sections: ' + openSections.join(', ');
        }
    }

}