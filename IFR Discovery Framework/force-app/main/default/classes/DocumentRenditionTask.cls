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
    * @method: execute() [public]
    * @desc: inherited method from the queueable interface, executed when the current job is executed in the queue.
    * @param {QueueableContex} renditionTaskContext: reffers to the context of the current task/job.
    */

    public void execute(QueueableContext renditionTaskContext) {

        /**
         * Follows interface segregation 
         * Lays the foundation of the API callout chain, hits the document rendition API.
         * Wait for a fixed interval of time.
         * depending upon the status of the API call re-enque the current job or hit the next API(synchronous callout to queue doc for extraction)
         * and enqueue the chained job(Asynchronous) to get the extracted data.  
         */
        
         //Getting essential parameters in order to make API call using seprate interfaces and static resources.
        String endPointTemplate =ConfigurationUtils.endPointService.get('Rendition');
        List<Object> parameter = new List<Object> {contentDocumentId};
        String apiEndPoint = String.format(endPointTemplate,parameter);
        // Creating a OAuth model for authenticating the API call
        OAuthService authenticationModel = new OAuthService();

        WebServicesUtils makeCallOuts = new WebServicesUtils();

        HttpRequest request = makeCallOuts.CreateHttpRequest(apiEndPoint,'GET ',authenticationModel);
        HttpResponse response = makeCallOuts.GetResponse(request);

        //setting up a timer to recheck status
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<30000); 

        if(response.getStatusCode()=202){
            //Re-enqueueing current job if status is still in progress
            System.enqueueJob(this);
        }else{
            //Making API call on order to Queue for extraction at rendition success
        endPointTemplate =ConfigurationUtils.endPointService.get('QueueForExtraction');  
        parameters = new List<Object> {contentDocumentId};
        apiEndPoint = String.format(endPointTemplate,parameters);

        JWTAuthService jwtAuthenticationModel = new JWTAuthService();

        HttpRequest request = makeCallOuts.createHttpRequest(apiEndPoint,'POST ',jwtAuthenticationModel);
        HttpResponse response = makeCallOuts.getResponse(request);
        
        //Enqueueing the get extracted Data (Asynchronous) job
        //follows the chainig of queueable classes in apex pattern 
        System.enqueueJob(new DocumentExtractionTask(contentDocumentId));

        }
     
}
