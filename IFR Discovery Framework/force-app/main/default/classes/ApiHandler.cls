public with sharing class ApiHandler {

    @AuraEnabled(cacheable=true)
     public static Map<String,Object> startExtract(String contentDocumentId, String accessToken)
     {

          String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
           return ApiCall.apiCallMethod(ApiEndPoint,'POST','Bearer ',accessToken);
     }
     @AuraEnabled(cacheable=true)
     public static Map<String,Object> filePreview(String contentDocumentId)
     {
          ID jobID = System.enqueueJob(new FileRenditionQueue(contentDocumentId));

          
          //poll the job id
          AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
          System.debug(jobInfo);
          String jobStatus = (String)jobInfo.Status;
          //while(jobStatus!='Completed' || jobStatus!='Aborted'||jobStatus!='Failed' );
          //polling
          // while(jobStatus!='Completed' || jobStatus!='Aborted'||jobStatus!='Failed' ){
          //      Long startTime = DateTime.now().getTime();
          //       while(DateTime.now().getTime()-startTime<5000);
          //      jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
          //      System.debug(jobInfo);
          //      jobStatus = (String)jobInfo.Status;

          // }

          //get the extracted json
          //Map<String,Object> texts = GetExtractedData.returnExtractedTexts(contentDocumentId);
          return null;
          

     }
    
     
     
 }
