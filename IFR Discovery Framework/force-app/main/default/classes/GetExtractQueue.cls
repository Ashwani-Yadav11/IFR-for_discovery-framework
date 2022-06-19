public with sharing class GetExtractQueue implements Queueable {
    public final String OdsrId;
    public GetExtractQueue() {
        this.odsrId=odsrId;

    }

    public void execute(QueueableContext qc){
        
        
        //setting up a timer
        Long startTime = DateTime.now().getTime();
    	while(DateTime.now().getTime()-startTime<1000); 
        
        String s = [
            SELECT OcrStatus 
            FROM OcrDocumentScanResult 
            WHERE Id =: odsrId
            ].OcrStatus;
        
        if(s!='SUCCESS'){
            System.enqueueJob(this);
        }else{
            //ODSR documemnt result status success get the extracted text
           Map<String,Object> text = (Map<String, Object>) JSON.deserialize( [
            SELECT ExtractedValues
            FROM OcrDocumentScanResult 
            WHERE Id =: odsrId
            ].ExtractedValues);
        }
       
       //Object results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
       
        
    }
}
