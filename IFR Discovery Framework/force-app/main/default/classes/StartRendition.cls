public with sharing class StartRendition {
    public static Object filePreview(String contentDocumentId){
        String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/files/'+contentDocumentId+'/rendition';
        System.debug(ApiEndPoint);
        HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'OAuth ', UserInfo.getSessionId());
        Http http = new Http();
        HttpResponse res = http.send(request);
       
       //Object results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
       System.debug(res); 
       return res;
    }
}
