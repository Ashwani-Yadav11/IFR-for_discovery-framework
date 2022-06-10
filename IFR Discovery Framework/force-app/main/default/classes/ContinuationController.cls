public with sharing class ContinuationController {
    //Endpoint to which we will be making the callout
    private static final String LONG_RUNNING_SERVICE_URL = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/form-reader/contentDocuments/069RM0000001hG8YAI/ocrDocumentScanResults';
    
    //continuation and cacheale should be true!
    @AuraEnabled(continuation=true cacheable=true)
    public static Object startRequest() {
		
      //Instantiate the Continaution class
      //Also, pass the timeout when instantiation
      Continuation con = new Continuation(40);

	  //this is the callback method	
      con.continuationMethod='processResponse';
      
      //Data that you want to pass to the callback method
      con.state='Hello, World!';
	  
      //Create the request
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setHeader('Authorization','Bearer '+'00DRM000000G7ke!AQEAQGrKcGI1wD6D7J9zBJBKIzuqBEfkFjN6bM3IaPzstruK98adw81qpdEv1MN9Y6JW1BIU3hu0eiXGcjOtZzN5dhGLY2.s');
      req.setEndpoint(LONG_RUNNING_SERVICE_URL);
	 
      //add the request to continuation instance
      //we can add upto 3 requests
      con.addHttpRequest(req);
      
	  //pass the continuation instance to the framework	
      return con;
    }
    
    // Callback method
    @AuraEnabled(cacheable=true)
    public static Object processResponse(List<String> labels, Object state) {
	  System.debug(' 🚀 ' +state);
      
      //labels[0] is the response of the first request
      HttpResponse response = Continuation.getResponse(labels[0]);

      String result = response.getBody();
      System.debug(' 🚀 ' +result);
      return result;
    }
}
