public with sharing class JWTAccessToken implements Authentication{
    public String getAccessToken()
    {
        Auth.JWT jwt = new Auth.JWT();
        jwt.setSub('ifr@df.project'); 
        jwt.setAud('https://login.stmfa.stm.salesforce.com/'); 
        jwt.setIss('3MVG9VwZxxW3bBQjG1oMgop1gmABIewIPxWwc5.aYe5VpuW5Dyu8UTYrszl8uVnT8_PPch5XJb08plxema5Wk');
        
        //Additional claims to set scope
        Map<String, Object> claims = new Map<String, Object>();
        claims.put('exp', system.now().gettime());
            
        jwt.setAdditionalClaims(claims);

        //Create the object that signs the JWT bearer token
        Auth.JWS jws = new Auth.JWS(jwt, 'salesforcetest');
        
        //Get the resulting JWS in case debugging is required
        String token = jws.getCompactSerialization();
        
        //Set the token endpoint that the JWT bearer token is posted to
        String tokenEndpoint = 'https://login.stmfa.stm.salesforce.com/services/oauth2/token';
        
        //POST the JWT bearer token
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);
        
        //Get the access token
        String accessToken = bearer.getAccessToken();
        System.debug(accessToken);
//         Http http = new Http();
//         HttpRequest request = new HttpRequest();
//         String ApiEndPoint = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/form-reader/contentDocuments/069RM0000001h63YAA/ocrDocumentScanResults';
//         request.setEndpoint(ApiEndPoint);
//         request.setMethod('POST');
// //String accessToken = '00DRM000000G7ke!AQEAQDU8ljR6m0mAwYlwLEEUUTSCsRaXLP078CN9YOOz04weycOEoHWoW7Wz2xMY.lQuLCqwtvBM_AFDhodEp9lALbsptS3V';
//         //Get Access token after JWT bearer Token hits the 
//         request.setHeader('Authorization','Bearer '+accessToken);
//         HttpResponse response  = http.send(request);
//         System.debug(response.getBody());
//                     Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
// 			System.debug(results);
        return accessToken;
    }
}