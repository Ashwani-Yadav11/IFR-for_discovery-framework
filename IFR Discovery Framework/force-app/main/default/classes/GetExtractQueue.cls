public with sharing class GetExtractQueue implements Queueable, Database.AllowsCallouts  {
    public final String contentDocumentId;
    public GetExtractQueue(String contentDocumentId) {
        this.contentDocumentId=contentDocumentId;

    }

    public void execute(QueueableContext qc){
        JWTAccessToken jwt = new JWTAccessToken();
        String accessToken  = jwt.getAccessToken();
        String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
        HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'Bearer ', accessToken);
        Http http = new Http();
        //setting up a timer
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<5000); 
        HttpResponse response = http.send(request);
        Map<String,Object> texts = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

        // String s = [
        //     SELECT OcrStatus 
        //     FROM OcrDocumentScanResult 
        //     WHERE Id =: odsrId
        //     ].OcrStatus;
       
        if(texts.get('ocrDocumentScanResults')==null){
            System.enqueueJob(this);
        }else{
            //ODSR documemnt result status success get the extracted text
           
            //System.debug(text);
            System.debug('Extraction Queue Success');
        }
       
       //Object results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

    }
}
