public with sharing class GetExtractQueue implements Queueable {
    public final String OdsrId;
    public GetExtractQueue(String odsrId) {
        this.odsrId=odsrId;

    }

    public void execute(QueueableContext qc){
        
        
        //setting up a timer
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<5000); 
        
        String s = [
            SELECT OcrStatus 
            FROM OcrDocumentScanResult 
            WHERE Id =: odsrId
            ].OcrStatus;
        
        if(s!='SUCCESS'){
            System.enqueueJob(this);
        }else{
            //ODSR documemnt result status success get the extracted text
           
            //System.debug(text);
            System.debug('Extraction Queue Success');
        }
       
       //Object results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

    }
}
