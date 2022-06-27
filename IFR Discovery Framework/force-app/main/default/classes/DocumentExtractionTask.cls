public with sharing class DocumentExtractionTask implements Queueable, Database.AllowsCallouts{
    String contentDocumentId;
    public DocumentExtractionTask(String contentDocumentId) {
        this.contentDocumentId=contentDocumentId;
    }

    public void execute(QueueableContext extractionTaskContext){
        String apiEndPointTemplate = endPointService.get('GetExtractedData');
        List<Object> parameters = new List<Object> {contentDocumentId};
        String apiEndPoint = String.format(endPointTemplate,parameters);  
        
        JWTAuthService jwtAuthenticationModel = new JWTAuthService();
        HttpRequest request = makeCallOuts.createHttpRequest(apiEndPoint,'GET ',jwtAuthenticationModel);
        HttpResponse response = makeCallOuts.getResponse(request);

        //setting up a timer
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<50000); 

        Map<String,Object> extractedDataInfo = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

        List<Object> scanResults  = (List<Object>)extractedDataInfo.get('ocrDocumentScanResults');

        if(scanResults.size()==0){
            System.enqueueJob(this);
        }else{      

            //extraction Complteted

        }

    }

}
