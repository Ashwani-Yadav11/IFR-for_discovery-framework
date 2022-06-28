public with sharing class DocumentExtractionTaskFinalizer implements Finalizer {

    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    private final static String logClassName = 'DocumentExtractionTaskFinalizer';
    private static String logMethodName;
    private static String logMessage;

    // //------------------------------------------------------------------------------
    // //======================= Implemented Methods =================================
    // //------------------------------------------------------------------------------

    String contentDocumentId;
    public DocumentExtractionTaskFinalizer(String contentDocumentId) {
        contentDocumentId = this.contentDocumentId;
    }


    /**
     * @method : execute() [public]
     * @desc   : method inherited from Finalizer interface.
     * this method is attached to the Queable task of getting extracted data.
     * and get executed on the success logic of that job.
     * @param{FinalizerContex} extractionFinalizerContext: reffers to the context of the current Finalizer.
     */
    public void execute(FinalizerContext extractionFinalizerContext) {

        logMethodName = 'execute';

        //Get the job Id of the parent queueable class to which it is attached.
        Id parentQueueableJobId = extractionFinalizerContext.getAsyncApexJobId();
        logMessage = 'Parent JobId recieved as ' + parentQueueableJobId;

        System.debug(logClassName + ' : ' + logMethodName + ' : ' + logMessage);

        //Invoke sendNotification function of EmailHelper class to send mail to the user with redirection link.
        EmailHelper.sendNotification(parentQueueableJobId, this.contentDocumentId);

        logMessage = 'Email Sent to the users';
        System.debug(logClassName + ' : ' + logMethodName + ' : ' + logMessage);


    }
}