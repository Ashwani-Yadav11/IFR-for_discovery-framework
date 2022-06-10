public with sharing class ApiHandler {

    @AuraEnabled(cacheable=true)
     public static Map<String,Object> startExtract(String contentDocumentId, String accessToken)
     {

          String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
           return ApiCall.apiCallMethod(ApiEndPoint,'POST','Bearer ',accessToken);
     }

     public static Map<String,Object> filePreview(String contentDocumentId)
     {
          String ApiEndPoint = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/files/'+contentDocumentId+'/rendition';
         return ApiCall.apiCallMethod(ApiEndPoint,'GET','OAuth ',UserInfo.getSessionId());
     }
 
     public static Map<String,Object> getExtract(String contentDocumentId,String accessToken)
     {
          String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
          return ApiCall.apiCallMethod(ApiEndPoint,'GET','OAuth ',accessToken);
     }
 
     
     
 }
