public with sharing class ApiHandler {

   
    public static Map<String,Object> startExtract(String contentDocumentId, String accessToken)
    {
        try{
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String ApiEndPoint = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/form-reader/contentDocuments/069RM0000001h63YAA/ocrDocumentScanResults';
        request.setEndpoint(ApiEndPoint);
        request.setMethod('POST');
        //Get Access token after JWT bearer Token hits the 
        System.debug(accessToken);
        request.setHeader('Authorization','Bearer '+StaticResources.accessToken);
        HttpResponse response  = http.send(request);
        
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           return results;

    
        }
        catch (Exception e){
            System.debug(e);
                }
        return null;
    }

    public static Map<String,Object> getExtract(String contentDocumentId, String numberOfPages)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Sending Parameters to along with endpoints to get the JSON results of text and coordinates
        //Number of ODSR Ids = Number of pages in the document
        String ApiEndPoint = StaticResources.API_URL_1 + contentDocumentId +  StaticResources.API_URL_2 + '?startPageIndex=1&'+'endPageIndex='+numberOfPages;
        request.setEndpoint(ApiEndPoint);
        request.setMethod('GET');
        
        HttpResponse response  = http.send(request);
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Required JSON -> Object
           return results;
        }
        return null;
    }

    
    
}
