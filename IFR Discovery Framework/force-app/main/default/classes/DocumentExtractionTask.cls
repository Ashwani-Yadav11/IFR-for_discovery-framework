public with sharing class DocumentExtractionTask implements Queueable, Database.AllowsCallouts{
    String contentDocumentId;
    public DocumentExtractionTask(String contentDocumentId) {
        this.contentDocumentId=contentDocumentId;
    }

    public void execute(QueueableContext extractionTaskContext){
        String apiEndPoint = endPointService.get('GetExtractedData');    
        JWTAuthService authenticationToken = new JWTAuthService();
        String accessToken = authenticationToken.getAccessToken();
        WebServicesUtils makeCallOuts = new WebServicesUtils();

        HttpRequest request = makeCallOuts.CreateHttpRequest(apiEndPoint,accessToken,'GET');
        HttpResponse response = makeCallOuts.GetResponse(request);

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
