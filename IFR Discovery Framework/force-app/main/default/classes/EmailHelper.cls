public class EmailHelper {
    public static boolean sendNotification(String jobId,String contentDocumentId)
    {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobId];
        message.toAddresses = new String[] { 'ashwani.yadav@salesforce.com' };
        message.subject = 'Extraction Status :' +jobId ;
        String jobStatus = (String) jobInfo.Status;
        if(jobStatus=='Completed')
        {
            message.htmlbody  = 'Document processing has been completed. Click the url to head back to question creation.\n '+'( '+ Url.getCurrentRequestUrl().toExternalForm()+'/lightning/n/IFRDemo?c__contentDocumentId='+contentDocumentId+' )';
        }
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            return true;
        } else {
           return false;
        }
    }
}