public with sharing class ScanDocument {
    public ScanDocument() {

    }
    /*
     *
     * @desc send the docuemnt to enstein ocr to extract text
     * @param {String} contentDocumentId is the id of document uploaded on platform
     * @param {String} sessionId id used as an authentication token while doing rest requests 
     */

     // 
    public  Map<String,Object> scanDocument(String contentDocumentId,Authentication authModel)
    {
        String accessToken = authModel.getAccessToken();
        // use the api handler to call the api methods
        Map<String,Object> previewUrls = ApiHandler.filePreview(contentDocumentId);
        Map<String,Object> odsrIds = ApiHandler.startExtract(contentDocumentId, accessToken);
        //Map<String,Object> response = Api.
       // Map<String,Object> results = Pulling.getExtractedText(contentDocumentId,accessToken);
        return odsrIds;
        //return null;
    }
}
