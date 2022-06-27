public with sharing class OAuthService implements IAuthenticationService {
    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='OAuthService';
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
    public String  getAccessToken(){

        logMethodName='getAccessToken';

        String accessToken = 'OAuth '+(String)UserInfo.getSessionId();

        logMessage='AccessToken is '+accessToken;
        System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);
        
        return accessToken;

    }
 
}
