public class JWTAccessToken implements Authentication{
      
    public String getAccessToken()
    {
        Auth.JWT jwt = new Auth.JWT();
        jwt.setSub('discovery@framework.ifr'); 
        jwt.setAud('https://login.stmfb.stm.salesforce.com/'); 
        jwt.setIss('3MVG9qKMKuRGRcbuIKjSYx5jdk547OuAGKaJxpMmHkrdsnGELAaemTxLaIIe15OPaeDI0ceUU.sc4qUGy2rUV');
        
        //Additional claims to set scope
        Map<String, Object> claims = new Map<String, Object>();
        claims.put('exp', system.now().gettime());
            
        jwt.setAdditionalClaims(claims);

        //Create the object that signs the JWT bearer token
        Auth.JWS jws = new Auth.JWS(jwt, 'salesforcetest');
        
        //Get the resulting JWS in case debugging is required
        String token = jws.getCompactSerialization();
        
        //Set the token endpoint that the JWT bearer token is posted to
        String tokenEndpoint = 'https://login.stmfb.stm.salesforce.com/services/oauth2/token';
        
        //POST the JWT bearer token
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);
        
        //Get the access token
        String accessToken = bearer.getAccessToken();
        System.debug(accessToken);
        return accessToken;
    }
}