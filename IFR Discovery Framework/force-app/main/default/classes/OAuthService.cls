public with sharing class OAuthService implements IAuthenticationService {

    public String  GetAccessToken(){

        String OauthAccessToken = (String)UserInfo.getSessionId();
        return OauthAccessToken;

    }
 
}
