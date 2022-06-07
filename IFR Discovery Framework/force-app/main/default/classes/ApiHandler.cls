public with sharing class ApiHandler {

    @AuraEnabled(cacheable=true)
     public static Map<String,Object> startExtract(String contentDocumentId, String accessToken)
     {
         
         Http http = new Http();
         HttpRequest request = new HttpRequest();
         //Datetime start = System.now();
         String ApiEndPoint = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
         System.debug(ApiEndPoint);
        // while(System.Now()<start.addSeconds(5)){}
         request.setEndpoint(ApiEndPoint);
         request.setMethod('POST');
         //Get Access token after JWT bearer Token hits the 
        // System.debug(accessToken);
        /**
         * @Todo access token dynamic insert not working
         */
         request.setHeader('Authorization','Bearer '+accessToken);
         HttpResponse response  = http.send(request);
         System.debug(response);
             // Deserialize the JSON string into collections of primitive data types.
             Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           System.debug(results);
           return results;
        
     
 
        // return null;
     }
 
     public static Map<String,Object> getExtract(String contentDocumentId, String numberOfPages)
     {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Datetime start = System.now();
        /**
         * @Todo put dynamic ip (currently showing exception)
         */
        String ApiEndPoint = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/form-reader/contentDocuments/069RM0000001hE2YAI/ocrDocumentScanResults?startPage=1&endPage=1';
        System.debug(ApiEndPoint);
       // while(System.Now()<start.addSeconds(5)){}
        request.setEndpoint(ApiEndPoint);
        request.setMethod('GET');
        //Get Access token after JWT bearer Token hits the 
       // System.debug(accessToken);
       /**
        * @Todo access token dynamic insert not working
        */
        request.setHeader('Authorization','Bearer '+'00DRM000000G7ke!AQEAQK9_Umbr2hFtFgBTSME_ThCA4F2NKOneU5s0z8EL9ajQI052P1T7MBzfITP0duSEdVknmY0EcgSZKNU4YqwFmz372ZyI');
        HttpResponse response  = http.send(request);
        System.debug(response);
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
          System.debug(results);
          return results;
     }
 
     
     
 }
