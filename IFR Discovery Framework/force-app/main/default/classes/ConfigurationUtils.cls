public with sharing class ConfigurationUtils {

    public static Map<String, String> endPointService = new Map<String, String>{
        'Rendition'=>URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/files/{0}/rendition',
        'QueueForExtraction'=>URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/form-reader/contentDocuments/{0}/ocrDocumentScanResults',
        'GetExtractedData'=>URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/{0}/ocrDocumentScanResults',   
        'tokenEndPoint'=>'https://login.stmfb.stm.salesforce.com/services/oauth2/token',
        'loginEndpoint'=>'https://login.stmfb.stm.salesforce.com/',
        'emailRedirection'=>URL.getSalesforceBaseUrl.toExternalForm()+'/lightning/n/IFRDemo?c__contentDocumentId='
    };

    public static Map<String,String> connectedAppService = new Map<String,String>{
        'clientId'=>'3MVG9qKMKuRGRcbuIKjSYx5jdk547OuAGKaJxpMmHkrdsnGELAaemTxLaIIe15OPaeDI0ceUU.sc4qUGy2rUV',
        'jwtBearerTokenName'=>'salesforcetest'
    };

    public static Map<String,String> emailService = new Map<String,String>{
        'adminEmailAddress'=>'discovery@framework.ifr'
        
    };
    
    public static String[] notificationEmails = new String[]{
        'abhishek.keshri@salesforce.com',
        'ashwani.yadav@salesforce.com'
    };
}