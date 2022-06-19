public with sharing class GetExtractFinalizer {

    public GetExtractFinalizer() {



    }
    public void execute(FinalizerContext ctx) {        
        Id parentQueueableJobId = ctx.getAsyncApexJobId();

        System.Debug('Executing Finalizer that was attached to Queueable Job ID: ' + parentQueueableJobId);
        if (ctx.getAsyncApexJobResult() == FinalizerParentJobResult.SUCCESS) {
            // Queueable executed successfully
            System.Debug('Parent Queueable (Job ID: ' + parentQueueableJobId + '): completed successfully!');

            // return extracted data json
        } else {
            // failed extraction ask for a retry
    }


    }
}
