public with sharing class StartExtract {
    public static  Map<String,Object> extractedData (String contentDocumentId,String accessToken){
        //make api call
   
        String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
        HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'POST', 'Bearer ', accessToken);
        Http http = new Http();
        HttpResponse res = http.send(request);
        System.debug(res);
        
        Long timeLimit = 2000;
        Long maxWaitingTime=120000;
        while(true){
            Long startTime = DateTime.now().getTime();
            if(timeLimit>=maxWaitingTime){
                break;
            }
             while(DateTime.now().getTime()-startTime<timeLimit);

             timeLimit=timeLimit*timeLimit;
            
             if(res.getStatusCode()==200||res.getStatusCode()==201||res.getStatusCode()==202)
            break;
            res = http.send(request);
        }
        Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
        System.debug(results);
        return results;


    }

}
