public with sharing class  GetExtractedData{
   
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> extractedData (String contentDocumentId,String odsrId){
        //make api call
      //make api call
   
        JWTAccessToken jwt = new JWTAccessToken();
        String accessToken = jwt.getAccessToken();
        System.debug(odsrId+'OdsrId');
      while(true){
          Long startTime = DateTime.now().getTime();
           while(DateTime.now().getTime()-startTime<5000);
          
        // if(res.getStatusCode()==200||res.getStatusCode()==201)
        // {
            // Map<String,Object> res = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            // List<Object> odsrs = res.get('ocrDocumentScanResults');
            // String status = odsrs[0].get('status');
            // if(status=='SUCCESS')
            String s = [
            SELECT OcrStatus 
            FROM OcrDocumentScanResult 
            WHERE Id =: odsrId
            ].OcrStatus;
          System.debug(s+'Ocr Status');
            if(s=='SUCCESS')
            break;
            
        // }
         
          //res = http.send(request);
      }
      String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
      HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'Bearer ', accessToken);
      Http http = new Http();
      HttpResponse res = http.send(request);
      System.debug(res);
      
      Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
      System.debug(results);
      return results;



    }
    public static Map<String,Object> returnExtractedTexts(String contentDocumentId){
      
      JWTAccessToken jwt = new JWTAccessToken();
      String accessToken = jwt.getAccessToken();
      String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
      HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'Bearer ', accessToken);
      Http http = new Http();
      HttpResponse res = http.send(request);
      System.debug(res);
      
      Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
      System.debug(results);
      return results;
    }
    /**
     * Testing purpose
     */
    @AuraEnabled(cacheable=true)
    public static Boolean returnExtractionStatus(String contentDocumetId){
      JWTAccessToken jwt = new JWTAccessToken();
      String accessToken  = jwt.getAccessToken();
      String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
      HttpRequest request = CreateHttpRequest.createHttpRequest(ApiEndPoint, 'GET', 'Bearer ', accessToken);
      Http http = new Http();
      //setting up a timer
     
      HttpResponse response = http.send(request);
      Map<String,Object> texts = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

      // String s = [
      //     SELECT OcrStatus 
      //     FROM OcrDocumentScanResult 
      //     WHERE Id =: odsrId
      //     ].OcrStatus;
     
      if(texts.get('ocrDocumentScanResults')==null){
         false;
      }else{
          //ODSR documemnt result status success get the extracted text
         
          //System.debug(text);
          true;
      }
    } 
}
