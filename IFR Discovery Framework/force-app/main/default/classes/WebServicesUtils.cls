public with sharing class WebServicesUtils {

    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='WebServicesUtils';
    public static String logMethodName;
    public static String logMessage;

    // //------------------------------------------------------------------------------
    // //======================= Implemented Methods =================================
    // //------------------------------------------------------------------------------

    /**
     * @method : FetchApiEndPoint() [public]
     * @desc   : An Utility method to fetch the API endpoint from static resources
     * based on the keyWord
     * @param {String} encodedDocument : base64 notation of the uploaded document 
     * @param {String} documentName : name of the document being uploaded 
     * @return {String} : return the string API Endpoint corrosponding to given Id
     */
   public  String FetchApiEndPoint(String jobType,String contentDocumentId){
    /**
     * This method fetches endpoint template based on the job type from the static resources
     * and format that as per the given parameter and send the desired string endpoint back
     */
        ConfigurationUtils staticResources = new ConfigurationUtils();
        String requiredEndpointTemplate = staticResources.endPointService.get(jobType);
        List<Object> parameter = new List<Object> {contentDocumentId};
        String requiredEndPoint = String.format(endPointTemplate,parameter);

        logMessage=' Required API Endpoint corrosponding to job '+jobType+' is '+requiredEndpoint;
        System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

        return requiredEndpoint;
    }


    /**
     * @method : createRequest() [public]
     * @desc   : An Utility method to create a HTTP request corrosponding to the given parameters
     * @param {String} apiEndPoint : formatted string representing the desired API endpoint 
     * @param {String} methodType : Type of API request you want to make(GET, PUT etc) 
     * @param {IAuthenticationService} : An authentication model realisation of the authentication interface carrying the authentication token and type.
     */
    public  HttpRequest createRequest(String apiEndPoint,String methodType,IAuthenticationService authModel) {
        /**
         * In this method we create a desired Http request
         * setting up the API endpoint, authentication model, mehtodType and return the Http request
         */
    
        //Extracting the Token and Auth type from the model
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


    /**
     * @method : getResponse() [public]
     * @desc   : An Utility method to hit the given HTTP request and recieve the response
     * @param {HttpRequest} request : a Http Request with all ther required parameters set.
     * @return {HttpResponse} : returns the recieved response after making the Http Request.
     */
    public HttpResponse getResponse(HttpRequest request) {
        /**
         * here we Hit the given Http request and recieve the response
         * which is returned back to the user
         */
        
        //make Http Request to the desired endpoint with adequate authentication
        HttpResponse response = http.send(request);

        return response;
    }
}
