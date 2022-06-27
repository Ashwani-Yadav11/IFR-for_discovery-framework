public with sharing class DocumentExtractionTask implements Queueable, Database.AllowsCallouts{
    
    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='DocumentRenditionTask';
    public static String logMethodName;
    public static String logMessage;

    String contentDocumentId;
    public DocumentExtractionTask(String contentDocumentId) {
        this.contentDocumentId=contentDocumentId;
    }
    /**
    * @method: execute() [public]
    * @desc: inherited method from the queueable interface, executed when the current job is executed in the queue.
    * @param {QueueableContex} extractionTaskContext: reffers to the context of the current task/job.
    */
    public void execute(QueueableContext extractionTaskContext){

        /**
         * Follows interface segregation 
         * Chained to a parent Queueable class
         * This method is executed when the rendition and queueing for extraction is success
         * i.e at the success logic of parent queueable class
         * Makes call out to the get extracted data API
         * checks if the extraction is completed 
         * depending upon above result re-enque itself or execute the finalizer 
         */

        //Getting essential parameters in order to make API call using seprate interfaces and static resources.
        String apiEndPointTemplate = ConfigurationUtils.endPointService.get('GetExtractedData');
        List<Object> parameter = new List<Object> {contentDocumentId};
        String apiEndPoint = String.format(endPointTemplate,parameter);  
        
        //Creating a Authentication model to authenticate our API Call.
        JWTAuthService jwtAuthenticationModel = new JWTAuthService();
        HttpRequest request = makeCallOuts.createHttpRequest(apiEndPoint,'GET ',jwtAuthenticationModel);
        HttpResponse response = makeCallOuts.getResponse(request);
        
        //Attaching the Finalizer to current Queueable job(Executed at the success of current Job)
        DocumentExtractionTaskFinalizer emailFinalizer = new DocumentExtractionTaskFinalizer(this.contentDocumentId);
        System.attachFinalizer(emailFinalizer);

        //setting up optimal interval between extracted data check
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<50000); 
        
        //Getting the current response body from the API response
        Map<String,Object> extractedDataInfo = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

        //Generating list of scan results from the nested JSON(list empty=>still queued for extraction)
        List<Object> scanResults  = (List<Object>)extractedDataInfo.get('ocrDocumentScanResults');

        if(scanResults.size()==0){
            //Data still in queue for processing
            System.enqueueJob(this);
        }else{      

            //extraction Complteted finalizer will be executed now 

        }

    }

}
