// //------------------------------------------------------------------------------
// //======================= Imports =================================
// //------------------------------------------------------------------------------
import { LightningElement, api, track } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import ASSESSMENT_QUESTION from "@salesforce/schema/AssessmentQuestion";
import ASSESSMENT_QUESTION_VERSION from "@salesforce/schema/AssessmentQuestionVersion";
import ASSESSMENT_QUESTION_VERSION_NAME_FIELD from "@salesforce/schema/AssessmentQuestionVersion.Name";
import ASSESSMENT_QUESTION_ID_FIELD from "@salesforce/schema/AssessmentQuestionVersion.AssessmentQuestionId";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class QuestionFieldEditor extends LightningElement {
  // //------------------------------------------------------------------------------
  // //======================= Variables for component ===========================
  // //------------------------------------------------------------------------------
  assessmentQuestion = ASSESSMENT_QUESTION;
  assessmentQuestionVersion = ASSESSMENT_QUESTION_VERSION;
  @track assessmentQuestionRecordId;
  @track assessmentQuestionVersionId;
  @api questionId = "";
  @track questionCreated = false;

  // //------------------------------------------------------------------------------
  // //======================= Variables for Question Form ===========================
  // //------------------------------------------------------------------------------
  strName = "";
  strDevName;
  strDataType;
  strQuestionCategory;
  strRelatedQuestionId;
  strFormulaResponseDataType;
  strQuestionText = "";
  strDescription = "";
  strIsActive;
  strResponseValues = "";

  // //------------------------------------------------------------------------------
  // //======================= Change Handlers =================================
  // //------------------------------------------------------------------------------
  questionTextChangeHandler(event) {
    if (this.strName == "" && this.strQuestionText == "")
      this.strName = event.target.value;

    this.strQuestionText = event.target.value;
  }
  descriptionChangeHandler(event) {
    this.strDescription = event.target.value;
  }
  activeChangeHandler(event) {
    this.strIsActive = event.target.value;
  }
  responseValuesChangeHandler(event) {
    this.strResponseValues = event.target.value;
  }
  nameChangedHandler(event) {
    this.strName = event.target.value;
  }
  devNameChangedHandler(event) {
    this.strDevName = event.target.value;
  }
  dataTypeChangedHandler(event) {
    this.strDataType = event.target.value;
  }
  questionCategoryChangedHandler(event) {
    this.strQuestionCategory = event.target.value;
  }
  relatedQuestionIdChangedHandler(event) {
    this.strRelatedQuestionId = event.target.value;
  }
  formulaResponseDataTypeChangedHandler(event) {
    this.strFormulaResponseDataType = event.target.value;
  }

  // //------------------------------------------------------------------------------
  // //======================= Drop zone Handlers =================================
  // //------------------------------------------------------------------------------
  questionTextDropHandler(event) {
    if (this.strName == "" && this.strQuestionText == "")
      this.strName = event.dataTransfer.getData("textValue");
    this.strQuestionText = event.dataTransfer.getData("textValue");
  }
  descriptionDropHandler(event) {
    if (this.strDescription == "")
      this.strDescription = event.dataTransfer.getData("textValue");
    else
      this.strDescription =
        this.strDescription + " " + event.dataTransfer.getData("textValue");
  }
  responseValuesDropHandler(event) {
    if (this.strResponseValues == "")
      this.strResponseValues = event.dataTransfer.getData("textValue");
    else
      this.strResponseValues =
        this.strResponseValues + "\n" + event.dataTransfer.getData("textValue");
  }
  nameDropHandler(event) {
    this.strName = event.dataTransfer.getData("textValue");
  }

  // //------------------------------------------------------------------------------
  // //======================= Methods for component =================================
  // //------------------------------------------------------------------------------

  /**
   * @method displayError : Display error in disappearing toast message.
   * @param {*} errorObj
   * @param {*} message
   */
  displayError(errorObj, message) {
    let errorMsg = "";
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
      variant: "error",
      title: "We hit a snag",
      message: message + errorMsg
    });
    this.dispatchEvent(failEvent);
  }

  /**
   * @method createQuestion : This method is used to insert record
   */
  createQuestion() {
    // Creating mapping of fields of Assessment Question  with values
    const qfields = {
      Name: this.strName,
      DeveloperName: this.strDevName,
      DataType: this.strDataType,
      QuestionCategory: this.strQuestionCategory,
      RelatedQuestionId: this.strRelatedQuestionId,
      FormulaResponseDataType: this.strFormulaResponseDataType
    };

    // Record details to pass to create method with api name of Object.
    const assessmentQuestionInput = {
      apiName: ASSESSMENT_QUESTION.objectApiName,
      fields: qfields
    };
    // LDS method to create record.
    createRecord(assessmentQuestionInput)
      .then((assessmentQuestionRecord) => {
        const qvfields = {
          QuestionText: this.strQuestionText,
          Description: this.strDescription,
          IsActive: this.strIsActive,
          ResponseValues: this.strResponseValues
        };
        console.log(qvfields);
        // Assessment Question Version entity has foreign key to AssessmentQuestionId
        qvfields[ASSESSMENT_QUESTION_ID_FIELD.fieldApiName] =
          assessmentQuestionRecord.id;
        this.assessmentQuestionRecordId = assessmentQuestionRecord.id;
        // Set the name to same as AssessmentQuestion entity's Name field
        qvfields[ASSESSMENT_QUESTION_VERSION_NAME_FIELD.fieldApiName] =
          this.strName;

        const assessmentQuestionVersionInput = {
          apiName: ASSESSMENT_QUESTION_VERSION.objectApiName,
          fields: qvfields
        };
        createRecord(assessmentQuestionVersionInput)
          .then((assessmentQuestionVersionRecord) => {
            const successEvent = new ShowToastEvent({
              variant: "success",
              title: "Success!",
              message: "We saved the assessment question version."
            });
            this.dispatchEvent(successEvent);
            this.assessmentQuestionVersionId =
              assessmentQuestionVersionRecord.id;
            this.questionCreated = true;
            this.sendQuestionNameToWrapper();
          })
          .catch((error) => {
            this.displayError(error, "Error in saving assessment question version");
          })
          .finally(() => {
            const closeFormEvent = new CustomEvent("close_form", {});
            this.dispatchEvent(closeFormEvent);
          });
      })
      .catch((error) => {
        this.displayError(error, "Error in saving assessment question");
      });
  }
  /**
   * @method sendQuestionNameToWrapper : This method creates an event and sends the questionName to wrapper
   */
  sendQuestionNameToWrapper() {
    const selectEvent = new CustomEvent("customevent", {
      detail: {
        id: this.questionId,
        name: this.strName
      }
    });
    this.dispatchEvent(selectEvent);
  }
  /**
   * Enables a drop zone on applied fields
   * @param {*} event 
   */
  allowDrop(event) {
    event.preventDefault();
  }
}
