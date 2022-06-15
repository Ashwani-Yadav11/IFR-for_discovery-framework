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
          Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Datetime start = System.now();
        request.setEndpoint(ApiEndPoint);
        request.setMethod('GET');
        request.setHeader('Authorization','OAuth '+ UserInfo.getSessionId());
        HttpResponse response  = http.send(request);
        System.debug(response);
            // Deserialize the JSON string into collections of primitive data types.
       // Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
         System.debug(JSON.deserializeUntyped(response.getBody()));
          return null;

     }
     @AuraEnabled(cacheable=true)
     public static Map<String,Object> getExtract(String contentDocumentId,String acct)
     {
          Authentication jwt = new JWTAccessToken();
          String accessToken = jwt.getAccessToken();
          String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
          return ApiCall.apiCallMethod(ApiEndPoint,'GET','Bearer ',accessToken);
     }
     @AuraEnabled(cacheable=true)
     public static Map<String,Object> renditionStart(String contentDocumentId)
     {
          Authentication jwt = new JWTAccessToken();
          String accessToken = jwt.getAccessToken();
          Object filePr = StartRendition.filePreview(contentDocumentId, accessToken);
          Map<String,Object> odsrs = StartExtract.extractedData(contentDocumentId, accessToken);
         //Map<String,Object> odsrs1 = (map<string,object>)odsrs.get('ocrDocumentScanResultInfos');
         //Map<String,Object> odsrs2 = (map<string,object>)odsrs1.get('0');
         
                  
         
     List<Object> lists = (List<Object>) odsrs.get('ocrDocumentScanResultInfos');
       //   Map<String,Object> odsr = (Map<String,Object>)lists[0];
         // String odsrId = (String) odsr.get('ocrDocumentScanResultId');
         //System.debug('Odsr -> '+odsrId);

          return odsrs;
     }     
     
     
 }
