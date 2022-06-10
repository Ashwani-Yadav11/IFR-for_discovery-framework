public with sharing  class apiCall {

    public static Map<String,Object> apiCallMethod(String endPoint,String method,String authType,String token) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Datetime start = System.now();
        request.setEndpoint(endPoint);
        request.setMethod(method);
        request.setHeader('Authorization',authType+Token);
        HttpResponse response  = http.send(request);
        System.debug(response);
            // Deserialize the JSON string into collections of primitive data types.
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
          System.debug(results);
          return results;

    }
}
