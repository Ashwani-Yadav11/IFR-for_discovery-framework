import { LightningElement,api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
//import EmailPreferencesStayInTouchReminder from '@salesforce/schema/User.EmailPreferencesStayInTouchReminder';
import ASSESSMENT_QUESTION from "@salesforce/schema/AssessmentQuestion";
import ASSESSMENT_QUESTION_VERSION from "@salesforce/schema/AssessmentQuestionVersion";
import ASSESSMENT_QUESTION_VERSION_NAME_FIELD from '@salesforce/schema/AssessmentQuestionVersion.Name';
import ASSESSMENT_QUESTION_ID_FIELD from '@salesforce/schema/AssessmentQuestionVersion.AssessmentQuestionId';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Id from '@salesforce/user/Id';
export default class QuestionFieldViewer extends LightningElement {
    assessmentQuestion = ASSESSMENT_QUESTION;
    assessmentQuestionVersion = ASSESSMENT_QUESTION_VERSION;
    userId = Id;
    strName='';
    strDevName;
    strDataType;
    strQuestionCategory;
    strRelatedQuestionId;
    strFormulaResponseDataType;
    strQuestionText='';
    strDescription='';
    strIsActive;
    strResponseValues='';
    @api saveAll;
    @api resetAll;
    // Change Handlers.
    questionTextChangeHandler(event){
        if(this.strName==''&&this.strQuestionText=='')
        this.strName = event.target.value;

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
        if(this.strName==''&&this.strQuestionText=='')
        this.strName = event.dataTransfer.getData("account_id");
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
    nameDropHandler(event)
    {
        this.strName = event.dataTransfer.getData("account_id");
    }
    //Generate Developer Name
    makeid() {
        var result           = '';
        var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for ( var i = 0; i < 20; i++ ) {
          result += characters.charAt(Math.floor(Math.random() * 
     charactersLength));
       }
       this.strDevName = this.userId+result; 
    }
    
 // ================================================================================
    // ACCESSOR METHODS
    // ================================================================================

  

    /**
     * Display error in disappearing toast message. Long term objective is to show error messages in footer.
     * @param {*} errorObj
     * @param {*} message
     */
     displayError(errorObj, message) {
        let errorMsg = '';
        if (errorObj && errorObj.body && errorObj.body.output) {
            const output = errorObj.body.output;
            if (output.fieldErrors) {
                const fieldErrors = output.fieldErrors;
                const fieldKeys = Object.keys(fieldErrors);
                if (fieldKeys.length > 0) {
                    errorMsg = fieldErrors[fieldKeys[0]][0].message;
                }
            }
            if (!errorMsg && output.errors) {
                const errors = output.errors;
                if (errors && errors.length > 0) {
                    errorMsg = errors[0].message;
                }
            }
        }

        const failEvent = new ShowToastEvent({
            'variant': 'error',
            'title': 'We hit a snag',
            'message': message + errorMsg
        });
        this.dispatchEvent(failEvent);
    }

    // Insert record.
    createQuestion(){
        
        // Creating mapping of fields of Account with values
        const fields = {
            "Name":this.strName,
            "DeveloperName":this.strDevName,
            "DataType":this.strDataType,
            "QuestionCategory":this.strQuestionCategory,
            "RelatedQuestionId":this.strRelatedQuestionId,
            "FormulaResponseDataType":this.strFormulaResponseDataType
        };
        console.log(fields);
        // Record details to pass to create method with api name of Object.
        const assessmentQuestionInput = {'apiName' : ASSESSMENT_QUESTION.objectApiName, fields};
        // LDS method to create record.
        createRecord(assessmentQuestionInput).then(assessmentQuestionRecord => {
            //alert('Question created with Id: ' +response.id);
            const qvfields = {
                "QuestionText":this.strQuestionText,
                "Description":this.strDescription,
                "IsActive":this.strIsActive,
                "ResponseValues":this.strResponseValues
            };
            console.log(qvfields);
             // Assessment Question Version entity has foreign key to AssessmentQuestionId
             qvfields[ASSESSMENT_QUESTION_ID_FIELD.fieldApiName] = assessmentQuestionRecord.id;
             // Set the name to same as AssessmentQuestion entity's Name field
             qvfields[ASSESSMENT_QUESTION_VERSION_NAME_FIELD.fieldApiName] = this.strName;
             
            const assessmentQuestionVersionInput = { apiName: ASSESSMENT_QUESTION_VERSION.objectApiName, fields: qvfields };
            createRecord(assessmentQuestionVersionInput)
                    .then(() => {
                        const successEvent = new ShowToastEvent({
                            'variant': 'success',
                            'title': 'Success!',
                            'message': 'Assessment Version Save Success',
                        });
                        this.dispatchEvent(successEvent);
                        // if (!wasSaveAndNewButtonClicked && this.shouldNavigateToNewlyCreatedQuestion) {
                        //     this[NavigationMixin.Navigate]({
                        //         type: 'standard__recordPage',
                        //         attributes: {
                        //             recordId: assessmentQuestionRecord.id,
                        //             objectApiName: 'AssessmentQuestion',
                        //             actionName: 'view'
                        //         }
                        //     });
                        // }
                    }).catch(error => {
                        this.displayError(error, 'Assessment Question Versions error');
                    }).finally(() => {
                        const closeFormEvent = new CustomEvent('close_form', {});
                        this.dispatchEvent(closeFormEvent);
                        // if (wasSaveAndNewButtonClicked) {
                        //     const reOpenModalEvent = new CustomEvent('saveAndNew', {});
                        //     this.dispatchEvent(reOpenModalEvent);
                        // }
                    });
        }).catch(error => {
            this.displayError(error, 'Assessment Question error');
        });
    }
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
    resetForm(event) {
        const fields = this.template.querySelectorAll("lightning-input-field");
        fields.forEach((field) => {
          field.reset();
        });
      }
}