public with sharing class ProcessDocument {
    /*
     * @desc Upload a file and set contentDoumentId
     * @param {String} base64 representation of a file
     * @param filename 
     * @param recordId
     */
    @AuraEnabled
    public static void uploadFile(String base64,String filename,String recordId )
    {
            String contentDocumentId = FileUploaderClass.uploadFile(base64, filename, recordId);
                return contentDocumentId;
    }
    /*
     * @desc extract text from the uploaded file
     * @param {String} contentDocumentId of the uploaded file
     * @return String
     */
    @AuraEnabled
    public static String ocrExtract(String contentDocumentId){
        // call to authorization
        String sessionId = UserInfo.getSessionId();
        console.log(sessionId);
        // call to ocr api
        Map<String,Object> texts = ScanDocument.scanDocument(contentDocumentId,sessionId);
        return null;
    }


}
