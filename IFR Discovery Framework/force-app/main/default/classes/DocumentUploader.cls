public with sharing class DocumentUploader {
   
    // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='DocumentUploader';
    public static String logMethodName;
    public static String logMessage;

    // //------------------------------------------------------------------------------
    // //======================= Method Definitions =================================
    // //------------------------------------------------------------------------------

    /**
    * @method : uploadDocument() [public]
    * @desc : acts as an intermediate method calls createContentVersion method 
    *         may be used for param preprocessing
    * @param {String} encodedDocument : base64 notation of the uploaded document 
    * @param {String} documentName : name of the document being uploaded 
    * @return {String} : returns the contentDocumentId 
    *                  Upload was successful, otherwise returns null
    */
    public String uploadDocument(String encodedDocument,String documentName){
        logMethodName='uploadDocument';
        /**
         * 
         * This section may be used any future preprocessing that may be required
         * 
         */
       
        // Call createContentVersion method 
        String contentDocumentId = this.createContentVersion(encodedDocument, documentName);
         if (contentDocumentId == null ) {

            logMessage='#####Error##### Create Content Version Unsucessful returned null';
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

            return null;
         }

         logMessage='ContentDocumentId is '+contentDocumentId;
         System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

         return contentDocumentId;
    }
    /**
    * @method : createContentVersion() [private]
    * @desc : Creates a contentVersion object and returns the contentDocumentId
    * @param {String} encodedDocument : base64 notation of the uploaded document 
    * @param {String} documentName : name of the document being uploaded 
    * @return {String} : returns the contentDocumentId 
    *                    upload was successful, otherwise returns null
    */
    private String createContentVersion(String encodedDocument, String documentName) {
        logMethodName='createContentVersion';

        //Create a contentVersion sObject;
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(encodedDocument);
        cv.Title = filename;
        cv.PathOnClient = filename;
        
          try {
            //insert the object in ContentVersion entity
            insert cv;
            
            //SOQL query to find contentDocumentId 
            String contentDocumentId = [
                SELECT ContentDocumentId 
                FROM ContentVersion 
                WHERE Id =: cv.Id
                ].ContentDocumentId;
             
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage); 
            return contentDocumentId;
        } 
        catch(DMLException error) {
          
            logMessage='#####Error##### '+(String)error;
            System.debug(logClassName+' : ' +logMethodName+' : '+logMessage); 

            return null;
        }
      }
    
}
