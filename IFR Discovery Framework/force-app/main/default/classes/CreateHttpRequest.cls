public with sharing class CreateHttpRequest {
    public static HttpRequest createHttpRequest(String endPoint,String method,String authType,String token) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Datetime start = System.now();
        request.setEndpoint(endPoint);
        request.setMethod(method);
        request.setHeader('Authorization',authType+Token);
        if(method=='POST')
        {
            Map<String,String> postBody = new Map<String,String>();
            
            String reqBody = JSON.serialize(postBody);
            request.setBody(reqbody);
        }
        return request;
        
    }
}
