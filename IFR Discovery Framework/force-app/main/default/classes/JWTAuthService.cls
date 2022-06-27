public with sharing class JWTAuthService implements IAuthenticationService{
    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='JWTAuthService';
    public static String logMethodName;
    public static String logMessage;

     // //------------------------------------------------------------------------------
    // //======================= Implemented Methods =================================
    // //------------------------------------------------------------------------------

    
    /**
     * @method : getAccessToken() [public]
     * @desc   : returns the accesstoken required for 
     * @return {String} : returns the accessToken to attach with Api calls
     */
    
    public String getAccessToken(){
        logMethodName='getAccessToken';

        //Create a Jwt Object
        Auth.JWT jwt = new Auth.JWT();
        jwt.setSub(ConfigurationUtils.emailService.get('adminEmailAddress')); 
        jwt.setAud(ConfigurationUtils.endPointService.get('loginEndpoint')); 
        jwt.setIss(ConfigurationUtils.connectedAppService.get('clientId'));
        
        //Additional claims to set scope
        Map<String, Object> claims = new Map<String, Object>();
        claims.put('exp', system.now().gettime());
            
        jwt.setAdditionalClaims(claims);

        //Create the object that signs the JWT bearer token
        Auth.JWS jws = new Auth.JWS(jwt, ConfigurationUtils.connectedAppService.get('jwtBearerTokenName'));
        
        //Get the resulting JWS in case debugging is required
        String token = jws.getCompactSerialization();
        
        //Set the token endpoint that the JWT bearer token is posted to
        String tokenEndpoint = ConfigurationUtils.endPointService.get('tokenEndpoint');
        
        //POST the JWT bearer token
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);
        
        //Get the access token
        String accessToken = 'Bearer '+bearer.getAccessToken();
        logMessage='AccessToken is '+accessToken;
        System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

        return accessToken;
    }

}
