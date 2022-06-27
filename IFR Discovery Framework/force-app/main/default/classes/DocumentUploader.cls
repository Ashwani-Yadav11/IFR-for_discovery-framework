public with sharing class DocumentUploader {
   
    public DocumentUploader() {
         
    }
    /**
    * 
    * @method uploadFile() 
    * @desc Creates a content version from a given file's base64 and name
    * 
    * @param {String} base64 - base64 string that represents the file
    * @param {String} filename - full file name with extension, i.e. 'products.csv'
    * @param {String} recordId - Id of the record you want to attach this file to
    * 
    * @return {ContentVersion} - returns the created ContentDocumentLink Id if the
    *   upload was successful, otherwise returns null
    */
    public String uploadDocument(String encodedText,String documentName){
        // Get the contentDocumentId from 
        String contentDocumentId = this.createContentVersion(base64, filename);
         if (contentDocumentId == null ) { return null; }
         return contentDocumentId;
    }
    private String createContentVersion(String base64, String filename) {
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        cv.Title = filename;
        cv.PathOnClient = filename;
        //cv.ContentDocumentId = '';
          try {
          insert cv;
          String s = [
            SELECT ContentDocumentId 
            FROM ContentVersion 
             WHERE Id =: cv.Id
              ].ContentDocumentId;
          // cv.TestId = s;
         // cv.ContentDocumentId = s;
          ApiHandler.filePreview(s);
          return cv.Id+' '+s;
        } catch(DMLException e) {
          System.debug(e);
          return null;
        }
      }
    
}
