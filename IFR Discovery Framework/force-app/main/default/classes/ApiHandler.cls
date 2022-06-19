public with sharing class ApiHandler {

    @AuraEnabled(cacheable=true)
     public static Map<String,Object> startExtract(String contentDocumentId, String accessToken)
     {

          String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
           return ApiCall.apiCallMethod(ApiEndPoint,'POST','Bearer ',accessToken);
     }

     public static Map<String,Object> filePreview(String contentDocumentId)
     {
          ID jobID = System.enqueueJob(new FileRenditionQueue(contentDocumentId));

          
          //poll the job id
          while

     }
    
     
     
 }
