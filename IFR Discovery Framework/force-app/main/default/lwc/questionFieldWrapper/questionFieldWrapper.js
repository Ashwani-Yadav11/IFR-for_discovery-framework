import { LightningElement,track } from 'lwc';

export default class QuestionFieldWrapper extends LightningElement {
    @track questions=[{
            id:1,
        },
    ];
    activeSections = ['1','2'];
    @track saveAll=false;
    @track resetAll=false;

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
    saveAllQuestion(event){
        event.preventDefault();
        this.saveAll=true;
        var x = document.querySelectorAll(".questionFieldSubmit");
        for(let i = 0;i<x.length;i++)
        {
            x[i].click();
        }
    }
   
    resetAllQuestion(event)
    {        event.preventDefault();
            this.resetAll = false;

    }

}