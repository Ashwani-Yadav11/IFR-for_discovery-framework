import { LightningElement,track } from 'lwc';

export default class QuestionFieldWrapper extends LightningElement {
    @track questions=[{
            id:'1',
            name:'Question 1',
        },
    ];
    activeSections = ['1'];
    @track saveAll=false;
    @track resetAll=false;
    @track ariaStatus = true;
    activeSectionMessage = '';
    @track msg;
   
   
    addNewQuestion(event){
        const questionName = 'Question '+(String)(this.questions.length+1);
        const questionId = (String)(this.questions.length+1);
        this.questions.push({id:questionId,name:questionName});
        this.activeSections.push(questionId);
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
    changeAriaStatus(){
        this.ariaStatus = !this.ariaStatus;
    }
}