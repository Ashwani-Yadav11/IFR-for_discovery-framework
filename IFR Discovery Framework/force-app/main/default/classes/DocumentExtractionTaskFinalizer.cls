public with sharing class DocumentExtractionTaskFinalizer implements Finalizer {
    String contentDocumentId;
    public DocumentExtractionTaskFinalizer(String contentDocumentId) {
        contentDocumentId=this.contentDocumentId;
    }

    public void execute(FinalizerContext context){
        Id parentQueueableJobId = context.getAsyncApexJobId();
        EmailHelper.sendNotification(parentQueueableJobId,this.contentDocumentId);
        
    }
}
