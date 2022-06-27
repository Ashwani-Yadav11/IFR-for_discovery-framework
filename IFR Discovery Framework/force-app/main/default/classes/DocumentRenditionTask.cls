public with sharing class DocumentRenditionTask implements Queueable, Database.AllowsCallouts  {
    public String contentDocumentId;
    public DocumentRenditionTask(String contentDocumentId) {
        this.contentDocumentId=contentDocumentId;
    }

    public void execute(QueueableContext renditionTaskContext) {

        String apiEndPoint = endPointService.get('Rendition');
        OAuthService authenticationToken = new OAuthService();
        String accessToken = authenticationToken.getAccessToken();
        WebServicesUtils makeCallOuts = new WebServicesUtils();

        HttpRequest request = makeCallOuts.CreateHttpRequest(apiEndPoint,accessToken,'GET ');
        HttpResponse response = makeCallOuts.GetResponse(request);

        //setting up a timer
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<30000); 

        if(response.getStatusCode()=202){
            System.enqueueJob(this);
        }else{

        String apiEndPoint = endPointService.get('QueueForExtraction');    
        JWTAuthService authenticationToken = new JWTAuthService();
        String accessToken = authenticationToken.getAccessToken();
        WebServicesUtils makeCallOuts = new WebServicesUtils();

        HttpRequest request = makeCallOuts.CreateHttpRequest(apiEndPoint,accessToken,'POST ');
        HttpResponse response = makeCallOuts.GetResponse(request);

        System.enqueueJob(new DocumentExtractionTask(contentDocumentId));

        }
     
}
