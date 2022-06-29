public with sharing class DocumentRenditionTask implements Queueable, Database.AllowsCallouts {

    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    private final static String logClassName = 'DocumentRenditionTask';
    private static String logMethodName;
    private static String logMessage;

    // //------------------------------------------------------------------------------
    // //======================= Implemented Methods =================================
    // //------------------------------------------------------------------------------

    public String contentDocumentId;
    public DocumentRenditionTask(String contentDocumentId) {
        this.contentDocumentId = contentDocumentId;
    }
    
    public Long timeInterval=10000;

    /**
     * @method: execute() [public]
     * @desc: inherited method from the queueable interface, executed when the current job is executed in the queue.
     * @param {QueueableContex} renditionTaskContext: reffers to the context of the current task/job.
     */
    public void execute(QueueableContext renditionTaskContext) {

        logMethodName = 'execute';
        /**
         * Follows interface segregation 
         * Lays the foundation of the API callout chain, hits the document rendition API.
         * Wait for a fixed interval of time.
         * depending upon the status of the API call re-enque the current job or hit the next API(synchronous callout to queue doc for extraction)
         * and enqueue the chained job(Asynchronous) to get the extracted data.  
         */

        //Getting essential parameters in order to make API call using seprate interfaces and static resources.
        String apiEndPoint = ConfigurationUtils.endPointService.get('Rendition');


        // Creating a OAuth model for authenticating the API call
        OAuthService authenticationModel = new OAuthService();
        WebServicesUtils makeCallOuts = new WebServicesUtils();
        HttpRequest request = makeCallOuts.createHttpRequest(apiEndPoint, 'GET ', authenticationModel);
        HttpResponse response = makeCallOuts.getResponse(request);

        logMessage = 'API callout sent and current response recieved of the API Call';
        System.debug(logClassName + ' : ' + logMethodName + ' : ' + logMessage);

        //setting up a timer to recheck status
        Long startTime = DateTime.now().getTime();
        while (DateTime.now().getTime() - startTime < timeInterval);

        if (response.getStatusCode() = 202) {

            //Exponentially Increase the polling Interval for the next check
            timeInterval = timeInterval*timeInterval;
            //Re-enqueueing current job if status is still in progress
            System.enqueueJob(this);

        } else {

            //Making API call in order to Queue for extraction at rendition success
            apiEndPoint = ConfigurationUtils.endPointService.get('QueueForExtraction');

            logMessage = 'API EndPoint for current document Id fetched' + apiEndPoint;
            System.debug(logClassName + ' : ' + logMethodName + ' : ' + logMessage);

            JWTAuthService jwtAuthenticationModel = new JWTAuthService();
            HttpRequest request = makeCallOuts.createHttpRequest(apiEndPoint, 'POST ', jwtAuthenticationModel);
            HttpResponse response = makeCallOuts.getResponse(request);
            /**
             * 
             * This section may be used any future preprocessing that may be required
             * 
             */

            //Enqueueing the get extracted Data (Asynchronous) job
            //follows the chainig of queueable classes in apex pattern 
            System.enqueueJob(new DocumentExtractionTask(contentDocumentId));

        }

    }