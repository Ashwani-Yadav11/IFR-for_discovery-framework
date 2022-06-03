public with sharing class ScanDocument {
    public ScanDocument() {

    }
    /*
     *
     * @desc send the docuemnt to enstein ocr to extract text
     * @param {String} contentDocumentId is the id of document uploaded on platform
     * @param {String} sessionId id used as an authentication token while doing rest requests 
     */
     public  Map<String,Object> scanDocument(String contentDocumentId,String sessionId)
     {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String ConnectApiEndpoint = StaticResources.API_URL+'/'+contentDocumentId+'/ocrDocumentScanResults';
        request.setEndpoint(ConnectApiEndpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        
        }
        return null; 
     }
}
