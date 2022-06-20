public class SendEmailFinalizer implements Finalizer {
    public void execute(FinalizerContext context){
      Id parentQueueableJobId = context.getAsyncApexJobId();
      EmailHelper.sendNotification(parentQueueableJobId,'');
      
  }
}