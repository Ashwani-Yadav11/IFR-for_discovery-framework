public with sharing class ApiHandler {

     // //------------------------------------------------------------------------------
    // //======================= DebugLogVariables =================================
    // //------------------------------------------------------------------------------
    public static String logClassName='ApiHandler';
    public static String logMethodName;
    public static String logMessage;

    
 
     public static void extractDocument(String contentDocumentId){

     /**
     * @method : extractDocument() [public static]
     * @desc   : Act as a enqueing gateway for the rendition-extraction async job chain
     * @param {String} contentdocumentId : unique id assigned to the document on uploading it into the org.
     */
          ID jobID = System.enqueueJob(new FileRenditionQueue(contentDocumentId));
          
          logMessage='Job Id corrosponding to the rendition-extraction async job chain is'+jobID;
          System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);

          //poll the job id
          AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
          /**
             * 
             * This section may be used any future preprocessing that may be required
             * 
             */
          String jobStatus = (String)jobInfo.Status;

          logMessage='Currnet status of the Job chain is '+jobStatus;
          System.debug(logClassName+' : ' +logMethodName+' : '+logMessage);
          

     
     }
    
     
     
 }
