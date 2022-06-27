public with sharing class DocumentRenditionTask implements Queueable, Database.AllowsCallouts  {
    
    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='DocumentRenditionTask';
    public static String logMethodName;
    public static String logMessage;

    
    public String contentDocumentId;
    public DocumentRenditionTask(String contentDocumentId) {
        this.contentDocumentId=contentDocumentId;
    }
    /**
     * Method Name: execute; method inherited from queueable interface, executed when the job is queued.
     * @param {QueueableContext} renditionTaskContext (represent the context of the current task/job )
     */

    public void execute(QueueableContext renditionTaskContext) {

        /**
         * 
         */
        String endPointTemplate = endPointService.get('Rendition');
        List<Object> parameters = new List<Object> {contentDocumentId};
        String apiEndPoint = String.format(endPointTemplate,parameters);
        OAuthService authenticationModel = new OAuthService();
        WebServicesUtils makeCallOuts = new WebServicesUtils();

        HttpRequest request = makeCallOuts.CreateHttpRequest(apiEndPoint,'GET ',authenticationModel);
        HttpResponse response = makeCallOuts.GetResponse(request);

        //setting up a timer
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<30000); 

        if(response.getStatusCode()=202){
            System.enqueueJob(this);
        }else{

        endPointTemplate = endPointService.get('QueueForExtraction');  
        parameters = new List<Object> {contentDocumentId};
        apiEndPoint = String.format(endPointTemplate,parameters);

        JWTAuthService jwtAuthenticationModel = new JWTAuthService();

        HttpRequest request = makeCallOuts.createHttpRequest(apiEndPoint,'POST ',jwtAuthenticationModel);
        HttpResponse response = makeCallOuts.getResponse(request);
        

        System.enqueueJob(new DocumentExtractionTask(contentDocumentId));

        }
     
}
