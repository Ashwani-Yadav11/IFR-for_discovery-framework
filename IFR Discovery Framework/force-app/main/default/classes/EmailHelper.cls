public class EmailHelper {
    public static boolean sendNotification(string jobId,String emailAddress)
    {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobId];
        message.toAddresses = new String[] { 'ashwani.yadav@salesforce.com' };
        message.subject = 'Extraction Status :' +jobId ;
        message.htmlbody  = 'The status of your extraction is as follows: '+(String)jobInfo.Status+' head back to the page and click start creating questions :)';
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            return true;
        } else {
           return false;
        }
    }
}