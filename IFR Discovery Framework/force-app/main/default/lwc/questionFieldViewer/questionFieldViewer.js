import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
//import EmailPreferencesStayInTouchReminder from '@salesforce/schema/User.EmailPreferencesStayInTouchReminder';
import ASSESSMENT_QUESTION from "@salesforce/schema/AssessmentQuestion";
import ASSESSMENT_QUESTION_VERSION from "@salesforce/schema/AssessmentQuestionVersion";

export default class QuestionFieldViewer extends LightningElement {
    assessmentQuestion = ASSESSMENT_QUESTION;
    assessmentQuestionVersion = ASSESSMENT_QUESTION_VERSION;
    strName='';
    strDevName;
    strDataType;
    strQuestionCategory;
    strRelatedQuestionId;
    strFormulaResponseDataType;
    strQuestionText;
    strDescription='';
    strIsActive;
    strResponseValues='';
    // Change Handlers.
    questionTextChangeHandler(event){
            this.strQuestionText = event.target.value;
    }
    descriptionChangeHandler(event){
        this.strDescription = event.target.value;
    }
    activeChangeHandler(event){
        this.strIsActive=event.target.value;
    }
    responseValuesChangeHandler(event){
        this.strResponseValues = event.target.value;
    }
    nameChangedHandler(event){

        this.strName = event.target.value;
        console.log(this.strName);
    }
    devNameChangedHandler(event){
        this.strDevName = event.target.value;
    }
    dataTypeChangedHandler(event){
        this.strDataType = event.target.value;
    }
    questionCategoryChangedHandler(event){
        this.strQuestionCategory = event.target.value;
    }
    relatedQuestionIdChangedHandler(event){
        this.strRelatedQuestionId = event.target.value;
    }
    formulaResponseDataTypeChangedHandler(event){
        this.strFormulaResponseDataType = event.target.value;
    }
    handleShowDesc(){
      this.showDesc = true;
    }
    handleHideDesc(){
      this.showDesc = false;
    }
    //dropHandlers
    questionTextDropHandler(event){
        this.strQuestionText = event.dataTransfer.getData("account_id");
    }
    descriptionDropHandler(event){
        if(this.strDescription=='')
        this.strDescription = event.dataTransfer.getData("account_id");
        else
        this.strDescription = this.strDescription+event.dataTransfer.getData("account_id");
    }
    responseValuesDropHandler(event){
        if(this.strResponseValues=='')
        this.strResponseValues = event.dataTransfer.getData("account_id");
        else
        this.strResponseValues = this.strResponseValues+'\n'+event.dataTransfer.getData("account_id");
    }
    // Insert record.
    // createQuestion(){
        
    //     // Creating mapping of fields of Account with values
    //     var fields = {
    //         "Name":this.strName,
    //         "DeveloperName":this.strDevName,
    //         "DataType":this.strDataType,
    //         "QuestionCategory":this.strQuestionCategory,
    //         "RelatedQuestionId":this.strRelatedQuestionId,
    //         "FormulaResponseDataType":this.strFormulaResponseDataType
    //     };
    //     // Record details to pass to create method with api name of Object.
    //     var objRecordInput = {'apiName' : 'AssessmentQuestion', fields};
    //     // LDS method to create record.
    //     createRecord(objRecordInput).then(response => {
    //         alert('Question created with Id: ' +response.id);
    //     }).catch(error => {
    //         alert('Error: ' +JSON.stringify(error));
    //     });
    // }
    dropElelment2(event)
    {
        this.strName = event.dataTransfer.getData("account_id");
    }
    allowDrop(event){
        event.preventDefault();
    }
    handleQuestionText(event)
    {
        this.questionText = event.target.value;
        console.log(this.questionText);
    }
}