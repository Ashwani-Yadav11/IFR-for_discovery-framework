public with sharing class GetExtractedData {
    public GetExtractedData() {
        
    }

    public static Map<String,Object> extractedData (String accessToken,String contentDocumentId){
        //make api call
      //make api call
   
      String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
      HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'Bearer ', accessToken);
      Http http = new Http();
      HttpResponse res = http.send(request);
      System.debug(res);
      

      while(true){
          Long startTime = DateTime.now().getTime();
           while(DateTime.now().getTime()-startTime<1000);
          
        if(res.getStatusCode()==200||res.getStatusCode()==201)
        {
            // Map<String,Object> res = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            // List<Object> odsrs = res.get('ocrDocumentScanResults');
            // String status = odsrs[0].get('status');
            // if(status=='SUCCESS')
            break;
            
        }
         
          res = http.send(request);
      }
      Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
      System.debug(results);
      return results;



    }
}
