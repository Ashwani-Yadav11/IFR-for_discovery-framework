public with sharing class StartRendition {
    public static Object filePreview(String contentDocumentId,String accessToken){
        String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/files/'+contentDocumentId+'/rendition';
        System.debug(ApiEndPoint);
        HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'Bearer ', accessToken);
        Http http = new Http();
        HttpResponse res = http.send(request);
        while(true)
        {
            Long startTime = DateTime.now().getTime();
            while(DateTime.now().getTime()-startTime<5000);
            //Check status of the call 
            if(res.getStatusCode()==200||res.getStatusCode()==201)
            break;
        
            res = http.send(request);
        }
       //Object results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
       System.debug(res); 
       return res;
    }
}
