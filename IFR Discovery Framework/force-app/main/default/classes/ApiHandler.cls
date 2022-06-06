public with sharing class ApiHandler {

    
    public static Map<String,Object> startExtract(String contentDocumentId, String accessToken)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String ApiEndPoint = StaticResources.API_URL_1 + contentDocumentId +  StaticResources.API_URL_2;
        request.setEndpoint(ApiEndPoint);
        request.setMethod('POST');
        //Get Access token after JWT bearer Token hits the 
        request.setHeader('Authorization','Bearer'+accessToken);
        Http response  = http.send(request);
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           return results;

        }
        return null;
    }

    public static Map<String,Object> getExtract(String contentDocumentId, String numberOfPages)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Sending Parameters to along with endpoints to get the JSON results of text and coordintes
        //Number of ODSR Ids = Number of pages in the document
        String ApiEndPoint = StaticResources.API_URL_1 + contentDocumentId +  StaticResources.API_URL_2 + '?startPageIndex=1&'+'endPageIndex='+numberOfPages;
        request.setEndpoint(ApiEndPoint);
        request.setMethod('GET');
        
        Http response  = http.send(request);
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           return results;
        }
        return null;
    }

    
    
}
