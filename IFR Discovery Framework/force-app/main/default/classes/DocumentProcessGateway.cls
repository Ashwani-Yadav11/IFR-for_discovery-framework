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
     * @method : processDocument() [public static]
     * @desc   : acts as a gateway to interact with lwc component
     * @param {String} encodedDocument : base64 notation of the uploaded document 
     * @param {String} documentName : name of the document being uploaded 
     * @return {String} : returns the contentDocumentId to LWC component
     */
    
    @AuraEnabled
    public static String processDocument(String encodedDocument,String documentName){
        try {
            /**
             * Follow proxy pattern
             * This method calls two methods of same class ( uploadDocument,extractDocument )
             * uploadDocument : upload the document in salesforce object returns : contentDocumentId
             * extractDocument : starts extraction on the returned contentDocumentId
             */
            logMethodName='processDocument';


            // UploadDocument and get the contentDocumentId needed for API calls
            String contentDocumentId = uploadDocument(encodedDocument, documentName);
            logMessage='ContentDocumentId is '+contentDocumentId;
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

            
            //Start the text extraction over the obtained contentDocumentId
            extractDocument(contentDocumentId);
            logMessage='DocumentExtraction Started';
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * @method : uploadDocument() [public static]
     * @desc   : uploads the file to contentVersion by calling method of DocumentUploader cls
     * @param {String} encodedDocument : base64 notation of the uploaded document 
     * @param {String} documentName : name of the document being uploaded 
     * @return {String} : returns the contentDocumentId 
     */
    
    @AuraEnabled
    public static String uploadDocument(String encodedDocument,String documentName){
        try {
            
            logMethodName='uploadDocument';
            
            //Call the upload method of DocumentUploader class
            DocumentUploader documentUploader = new DocumentUploader();
            String contentDocumentId = documentUploader.uploadDocument(encodedDocument, documentName);
            logMessage='ContentDocumentId is '+contentDocumentId;
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

            return contentDocumentId;
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * @method : extractDocument() [public static]
     * @desc   : calls method of ApiHandler class to start the text Extraction from the document 
     * @param {String} contentDocumentId : the contentDocumentId to perform extraction Upon  
     * @param {String} documentName : name of the document being uploaded 
     * @return {void}  
     */

    @AuraEnabled
    public static void extractDocument(String contentDocumentId){
        try {
            logMethodName='extractDocument';

            // Call the extractDocument Method of APIHandler class to start extraction
            ApiHandler apiHandler = new ApiHandler();
            apiHandler.extractDocument(contentDocumentId);
            logMessage = 'Document Extraction has started wait for email confirmation';
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);
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
