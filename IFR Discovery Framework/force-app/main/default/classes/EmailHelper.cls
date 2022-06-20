public class EmailHelper {
    public static boolean sendNotification(string jobId,String emailAddress)
    {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'ashwani.yadav@salesforce.com' };
        message.subject = 'Extraction Status :' +jobId ;
        message.htmlbody  = 'The status of your extraction is as follows '+(String)jobId.Status;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            return true;
        } else {
           return false;
        }
    }
}