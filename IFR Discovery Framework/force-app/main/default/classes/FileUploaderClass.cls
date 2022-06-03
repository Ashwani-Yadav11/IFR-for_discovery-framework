public with sharing class FileUploaderClass {
    /*
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
   
  public static ContentVersion uploadFile(String base64, String filename, String recordId) {
        ContentVersion cv = createContentVersion(base64, filename);
       // ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
        if (cv == null ) { return null; }
        return cv;
  }
  /*
   * @method createContentVersion() [private]
   * @desc Creates a content version from a given file's base64 and name
   * 
   * @param {String} base64 - base64 string that represents the file
   * @param {String} filename - full file name with extension, i.e. 'products.csv'
   * 
   * @return {ContentVersion} - returns the newly created ContentVersion, or null
   *   if there was an error inserting the record
   */
  private static ContentVersion createContentVersion(String base64, String filename) {
    ContentVersion cv = new ContentVersion();
    cv.VersionData = EncodingUtil.base64Decode(base64);
    cv.Title = filename;
    cv.PathOnClient = filename;
    
    try {
      insert cv;
      return cv;
    } catch(DMLException e) {
      System.debug(e);
      return cv2;
    }
  }
  // private static ContentDocumentLink createContentLink(String contentVersionId, String recordId) {
  //         if (contentVersionId == null || recordId == null) { return null; }
  //     ContentDocumentLink cdl = new ContentDocumentLink();
  //     cdl.ContentDocumentId = [
  //     SELECT ContentDocumentId 
  //     FROM ContentVersion 
  //     WHERE Id =: contentVersionId
  //     ].ContentDocumentId;
  //     cdl.LinkedEntityId = recordId;
  //     // ShareType is either 'V', 'C', or 'I'
  //     // V = Viewer, C = Collaborator, I = Inferred
  //     cdl.ShareType = 'V';
  //     try {
  //     insert cdl;
  //     return cdl;
  //     } catch(DMLException e) {
  //     System.debug(e);
  //     return null;
  //     }
  // }

   
}