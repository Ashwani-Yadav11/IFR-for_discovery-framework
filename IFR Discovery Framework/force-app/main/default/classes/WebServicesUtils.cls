public with sharing class WebServicesUtils {

   public  String FetchApiEndPoint(String jobType){
        ConfigurationUtils staticResources = new ConfigurationUtils();
        String requiredEndpoint = staticResources.endPointService.get(jobType);
        return requiredEndpoint;
        
    }

    public  HttpRequest createRequest(String apiEndPoint,String methodType,IAuthenticationService authModel) {
        String authenticationInfo = authModel.getAccessToken();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiEndPoint);
        request.setMethod(methodType);
        request.setHeader('Authorization',authenticationInfo);
        if(methodType=='POST')
        {
            Map<String,String> postBody = new Map<String,String>();
            
            String reqBody = JSON.serialize(postBody);
            request.setBody(reqbody);
        }
        return request;

    }

    public  HttpResponse getResponse(HttpRequest request) {
        HttpResponse response = http.send(request);
        return response;
    }
}
