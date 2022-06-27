public with sharing class WebServicesUtils {

   public static String FetchApiEndPoint(String jobType){
        ConfigurationUtils staticResources = new ConfigurationUtils();
        String requiredEndpoint = staticResources.endPointService.get(jobType);
        return requiredEndpoint;
        
    }

    public static HttpRequest CreateRequest(String apiEndPoint,String accessToken,String method) {
        HttpRequest request = CreateHttpRequest.createHttpRequest(apiEndPoint, method, 'Bearer ', accessToken);
        return request;
    }

    public static HttpResponse GetResponse(HttpRequest request) {
        HttpResponse response = http.send(request);
        return response;
    }
}
