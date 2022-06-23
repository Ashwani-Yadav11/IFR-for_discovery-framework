public class SendEmailFinalizer implements Finalizer {
  public String contentDocumentId;
  public SendEmailFinalizer(String contentDocumentId){
    this.contentDocumentId = contentDocumentId;
  }
    public void execute(FinalizerContext context){
      Id parentQueueableJobId = context.getAsyncApexJobId();
      EmailHelper.sendNotification(parentQueueableJobId,this.contentDocumentId);
      
  }
}