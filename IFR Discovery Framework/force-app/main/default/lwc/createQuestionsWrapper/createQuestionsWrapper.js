// //------------------------------------------------------------------------------
// //======================= Imports =================================
// //------------------------------------------------------------------------------
import { LightningElement, track } from "lwc";

export default class CreateQuestionsWrapper extends LightningElement {
  // //------------------------------------------------------------------------------
  // //======================= Variables for component ===========================
  // //------------------------------------------------------------------------------

  //One default entry to start with
  @track questions = [
    {
      id: 1,
      name: "Question 1"
    }
  ];
  @track activeSections = [1];
  activeSectionsMessage = "";

  // //------------------------------------------------------------------------------
  // //======================= Methods for component =================================
  // //------------------------------------------------------------------------------

  /**
   * @method handleCustomEvent : This method is used to catch the question name from child
   *                             and update the name of question in parent component
   * @param {event} event : event from child class
   */
  handleCustomEvent(event) {
    //Get the questionId and questionName from event.detail
    const questionId = event.detail.id;
    const questionName = event.detail.name;

    //Iterate over the array and update the questionName
    this.questions.forEach((question) => {
      if (question.id == questionId) {
        question.name = questionName;
      }
    });

    //Deactive this accordian section and create a new question for user to edit
    let helperArray = this.activeSections;
    helperArray = helperArray.filter((item) => item !== questionId);
    this.activeSections = helperArray;
    this.addNewQuestion();
  }
  /**
   * @method addNewQuestion : This method is used to create a new question template
   */
  addNewQuestion() {
    const questionName = "Question " + String(this.questions.length + 1);
    const questionId = this.questions.length + 1;
    this.questions.push({ id: questionId, name: questionName });
    this.activeSections = [questionId];
  }
}
