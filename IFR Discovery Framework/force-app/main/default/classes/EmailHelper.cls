public class EmailHelper {
    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='EmailHelper';
    public static String logMethodName;
    public static String logMessage;


    /**
     * @method : sendNotification() [public static]
     * @desc   : create a email with proper redirection email
     * @param {String} jobId : jobId of enqueued job
     * @param {String} contentDocumentId : documentId of the uploaded document 
     * @return {String} : returns boolean sta
     */
    
    public static boolean sendNotification(String jobId,String contentDocumentId)
    {
        logMethodName='sendNotification';

        //Create an Instace of Messagin.SingleEmailMessage
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

        //SOQL query to fetch job info
        AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobId];
        
        message.toAddresses = ConfigurationUtils.notificationEmails;
        message.subject = 'Extraction Status :' +jobId ;
        
        
        String jobStatus = (String) jobInfo.Status;
        if(jobStatus=='Completed')
        {
            message.htmlbody  = 'Document processing has been completed. Click the url to head back to question creation.\n '+'( '+ConfigurationUtils.endPointService('emailRedirection')+contentDocumentId+' )';
        }

        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            
            logMessage='Email Sent sucessfully';
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

            return true;
        } else {
           return false;
        }
    }
}