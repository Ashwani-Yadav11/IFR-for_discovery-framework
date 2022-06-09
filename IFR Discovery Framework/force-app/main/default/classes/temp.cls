public with sharing class ApiHandler {

    @AuraEnabled(cacheable=true)
     public static Map<String,Object> startExtract(String contentDocumentId, String accessToken)
     {
         
         Http http = new Http();
         HttpRequest request = new HttpRequest();
         //Datetime start = System.now();
         String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
         System.debug(ApiEndPoint);
        
        request.setEndpoint(ApiEndPoint);
         
         request.setMethod('POST');
         
        
         request.setHeader('Authorization','Bearer '+accessToken);
         //request.setHeader('Authorization','OAuth '+UserInfo.getSessionId());
         request.setHeader('Content-Type', 'application/json');
         Map<String,String> postBody = new Map<String,String>();
         //postBody.put('startPageIndex','1');
        // postBody.put('endPageIndex','1');
         String reqBody = JSON.serialize(postBody);
         request.setBody(reqbody);
         HttpResponse response  = http.send(request);
         System.debug(response);
             // Deserialize the JSON string into collections of primitive data types.
            //  List<Object> lstproperty = (lLst<Object>)JSON.deserializeUntyped(response.getBody()); 
            // //Now loop over this 
            // for(Object propertyObj:lstproperty){
            //     Map<String, Object> property = (Map<String, Object>)propertyObj;
            // }
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           System.debug(results);
           return results;
        
     
 
        // return null;
     }
 
     public static Map<String,Object> getExtract(String contentDocumentId,String accessToken)
     {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Datetime start = System.now();
      
        String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
        System.debug(ApiEndPoint);
        request.setEndpoint(ApiEndPoint);
        request.setMethod('GET');
        
       
        request.setHeader('Authorization','Bearer '+accessToken);
        HttpResponse response  = http.send(request);
        System.debug(response);
            // Deserialize the JSON string into collections of primitive data types.
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
          System.debug(results);
          return results;
     }
 
     
     
 }