public class FileRenditionQueue implements Queueable  {
       public final String contentDocumentId;
    
    public FileRenditionQueue(String contentDocumentId){
        this.contentDocumentId = contentDocumentId;
    }
    public void execute(QueueableContext qc){
        
        String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/files/'+this.contentDocumentId+'/rendition';
        System.debug(ApiEndPoint);
        HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'OAuth ', UserInfo.getSessionId());
        Http http = new Http();
        //Attaching the finalizer
        SendEmailFinalizer emailFinalizer = new SendEmailFinalizer();
            System.attachFinalizer(emailFinalizer);

        //setting up a timer
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<1000); 
        
        HttpResponse res = http.send(request);
        
        if(res.getStatusCode()==202){
            System.enqueueJob(this);
        }else{
            
            Authentication authModel = new JWTAccessToken();
         	String accessToken = authModel.getAccessToken();
         	ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
        	//System.debug(ApiEndPoint);
        	request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'POST', 'Bearer ', accessToken);
        	res = http.send(request);
            Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());

            //send odsr id as a parameter to the get extract class
            Map<String,Object> odsr = (Map<String,Object>)results[0];
            String odsrId = (String) odsr.get('ocrDocumentScanResultId');

            System.enqueueJob(new GetExtractQueue(odsrId));
            
        }
       
       //Object results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
       System.debug(res); 
        
        
    }
}
