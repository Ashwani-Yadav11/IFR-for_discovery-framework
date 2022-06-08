import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import EmailPreferencesStayInTouchReminder from '@salesforce/schema/User.EmailPreferencesStayInTouchReminder';

export default class QuestionFieldViewer extends LightningElement {
    strName='';
    strDevName;
    strDataType;
    strQuestionCategory;
    strRelatedQuestionId;
    strFormulaResponseDataType;

    // Change Handlers.
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
    // Insert record.
    createQuestion(){
        
        // Creating mapping of fields of Account with values
        var fields = {
            "Name":this.strName,
            "DeveloperName":this.strDevName,
            "DataType":this.strDataType,
            "QuestionCategory":this.strQuestionCategory,
            "RelatedQuestionId":this.strRelatedQuestionId,
            "FormulaResponseDataType":this.strFormulaResponseDataType
        };
        // Record details to pass to create method with api name of Object.
        var objRecordInput = {'apiName' : 'AssessmentQuestion', fields};
        // LDS method to create record.
        createRecord(objRecordInput).then(response => {
            alert('Question created with Id: ' +response.id);
        }).catch(error => {
            alert('Error: ' +JSON.stringify(error));
        });
    }
    dropElelment2(event)
    {
        this.strName = event.dataTransfer.getData("account_id");
    }
    allowDrop(event){
        event.preventDefault();
    }
}