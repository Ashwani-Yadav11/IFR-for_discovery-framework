public with sharing class ConfigurationUtils {

    public static Map<String, String> endPointService = new Map<String, String>{
        'Rendition'=>URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/files/{0}/rendition',
        'QueueForExtraction'=>URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/form-reader/contentDocuments/{0}/ocrDocumentScanResults',
        'GetExtractedData'=>URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/{0}/ocrDocumentScanResults'    
    };
}