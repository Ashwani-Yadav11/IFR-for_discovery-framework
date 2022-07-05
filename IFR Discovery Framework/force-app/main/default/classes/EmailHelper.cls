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
            message.htmlbody  =  message.htmlbody =
            '<p>Successfully extracted the text from the uploaded pdf documents. Click the link here to start creating Assessment Questions from the extracted text. </p> <br> ' +
            Url.getCurrentRequestUrl().toExternalForm()+'/lightning/page/home?c__contentDocumentId='+contentDocumentId;
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