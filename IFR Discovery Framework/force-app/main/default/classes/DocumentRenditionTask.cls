public with sharing class DocumentRenditionTask, Database.AllowsCallouts {
    public String contentDocumentId;
    public DocumentRenditionTask(String contentDocumentId) {
        contentDocumentId=this.contentDocumentId;
    }

    public void execute(QueueableContext renditionTask) {

        String apiEndPoint = endPointService.get('Rendition');
        

        
    }
}
