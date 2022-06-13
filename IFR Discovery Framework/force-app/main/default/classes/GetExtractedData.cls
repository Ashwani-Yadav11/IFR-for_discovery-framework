public with sharing class GetExtractedData {
    public GetExtractedData() {
        
    }

    public static Map<String,Object> extractedData (String accessToken,String contentDocumentId){
        //make api call
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String endPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
        request.setEndpoint(endPoint);
        request.setMethod('POST');
        String authType = 'Bearer ';
        request.setHeader('Authorization',authType+accessToken);
        HttpResponse response  = http.send(request);
        System.debug(response);
            // Deserialize the JSON string into collections of primitive data types.
       // Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
         //

        while(True){
            Long startTime = DateTime.now().getTime();
             while(DateTime.now().getTime()-startTime<1000);
             //Check status of the call 
             // if not done wait 


             //if recieved the results break


        }
        System.debug(results);
        return results;


    }
}
