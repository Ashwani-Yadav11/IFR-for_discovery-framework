public with sharing class DocumentProcessGateway {

    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='DocumentProcessGateway';
    public static String logMethodName;
    public static String logMessage;
    // //------------------------------------------------------------------------------
    // //======================= AuraEnabledMethods =================================
    // //------------------------------------------------------------------------------

    /**
     * Method Name: processDocument;; acts as a gateway to interact with lwc component
     * @param {String} encodedText ( base64 notation of the uploaded document )
     * @param {String} documentName ( name of the document being uploaded )
     * @return {String} 
     */
    
    @AuraEnabled
    public static String processDocument(String encodedText,String documentName){
        try {
            /**
             * Follow proxy pattern
             * This method calls two methods of same class ( uploadDocument,extractDocument )
             * uploadDocument : upload the document in salesforce object returns : contentDocumentId
             * extractDocument : starts extraction on the returned contentDocumentId
             */

            // UploadDocument and get the contentDocumentId needed for API calls
            String contentDocumentId = uploadDocument(encodedText, documentName);
            System.debug('DocumentProcessGateway : processDocument : ContentDocumentId is '+contentDocumentId);
            
            //Start the text extraction over the obtained contentDocumentId
            extractDocument(contentDocumentId);
            System.debug('DocumentProcessGateway : processDocument : DocuementExtraction Started');

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static String uploadDocument(String encodedText,String documentName){
        try {
            String contentDocumentId =  FileUploaderClass.uploadFile(base64, filename, recordId);
            return contentDocumentId;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static String extractDocument(String contentDocumentId){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static String getContentVersionId(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}
