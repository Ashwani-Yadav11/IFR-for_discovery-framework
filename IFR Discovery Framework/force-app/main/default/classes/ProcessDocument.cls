public with sharing class ProcessDocument {
    /*
     * @desc Upload a file and set contentDoumentId
     * @param {String} base64 representation of a file
     * @param filename 
     * @param recordId
     */
    // @AuraEnabled
    // public static String uploadFile(String base64,String filename,String recordId )
    // {
    //         return FileUploaderClass.uploadFile(base64, filename, recordId);
    //             //return contentDocumentId;
    // }

    @AuraEnabled
    public static String processDocument(String base64,String filename, String recordId){
        try {
           String contentDocumentId =  FileUploaderClass.uploadFile(base64, filename, recordId);
           //ApiHandler.filePreview(contentDocumentId);
           // extractDocument(contentDocumentId);
          // Map<String,Object> results = ApiHandler.startExtract(contentDocumentId, '');
           return contentDocumentId;
           //return contentDocumentId; 
        //    JWTAccessToken authModel = new JWTAccessToken();
        //     return authModel.getAccessToken();
             //ScanDocument scm = new ScanDocument();
             
            // return scm.scanDocument(contentDocumentId,authModel);
           // return odsrIds;
             
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    /*
     * @desc extract text from the uploaded file
     * @param {String} contentDocumentId of the uploaded file
     * @return {String}
     */
    // @AuraEnabled
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> extractDocument(String contentDocumentId){
       
            
            Authentication authModel = new JWTAccessToken();
            //return authModel.getAccessToken();
            ScanDocument scm = new ScanDocument();
             
            return scm.scanDocument(contentDocumentId,authModel);
           // return odsrIds;
    
    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> startRenditionAndExtractText(String contentDocumentId){
         Map<String,Object> results = ApiHandler.filePreview(contentDocumentId);
         return results;
    }
    // /*
    //  * @desc Upload the question in asses
    //  * 
    //  */
    // public static String createQuestion(String questionParam)
    // {
    //         //There are two api that we are supposesd to hit 
    //         //Assessment Question and Assessment Question Version
    // }
        @AuraEnabled(cacheable=true)
        public static string getContentVersionId(String contentDocumentId){
            String s = [
            SELECT Id 
            FROM ContentVersion 
            WHERE ContentDocumentId =: contentDocumentId
            ].Id;
            return s;
        }

    /**
     * Conitnuation Logic
     */
    
     
}
