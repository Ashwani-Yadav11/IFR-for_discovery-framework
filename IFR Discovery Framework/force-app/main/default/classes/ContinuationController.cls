public with sharing class ContinuationController {
  //Endpoint to which we will be making the callout
  private static final String LONG_RUNNING_SERVICE_URL = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/form-reader/contentDocuments/069RM0000001hG8YAI/ocrDocumentScanResults';
  
  public static String requestLabel1;
  // Unique label for the chained callout request
  public static String requestLabel2;
  // Result of initial callout
  public static String result1 {get;set;}
  // Result of chained callout
  public  static String result2 {get;set;}
  public static String contentDoc {get;set;}
  //continuation and cacheale should be true!
  @AuraEnabled(continuation=true cacheable=true)
  public static Object startRequest() {
  
    //Instantiate the Continaution class
    //Also, pass the timeout when instantiation
    Continuation con = new Continuation(60);

  //this is the callback method	
    con.continuationMethod='processResponse';
    
    //Data that you want to pass to the callback method
    con.state='Hello, World!';
  
    //Create the request
    HttpRequest req = new HttpRequest();
    req.setMethod('GET');
    Authentication auth = new JWTAccessToken();
      String accessToken  = auth.getAccessToken();
    req.setHeader('Authorization','Bearer '+accessToken);
    req.setEndpoint(LONG_RUNNING_SERVICE_URL);
 
    //add the request to continuation instance
    //we can add upto 3 requests
     con.addHttpRequest(req);
    
  //pass the continuation instance to the framework	
    return con;
  }
  @AuraEnabled(continuation=true cacheable=true)
  public static Object filePreview(String contentDocumentId) {
  contentDoc = contentDocumentId;
      System.debug('filePreview'+contentDocumentId);
      //Instantiate the Continaution classs
      //Also, pass the timeout when instantiation
      Continuation con = new Continuation(120);

      //this is the callback method	
      con.continuationMethod='startExtract';
      
      //Data that you want to pass to the callback method
      con.state=contentDocumentId;
     // con.contentDocumentId=contentDocumentId;
      //Create the request
      String ApiEndPoint = 'https://discoveryframeworkidiscover-dev-ed.my.stmfb.stm.salesforce.com/services/data/v55.0/connect/files/'+contentDocumentId+'/rendition';
      System.debug(ApiEndPoint);
      Authentication auth = new JWTAccessToken();
      String accessToken  = auth.getAccessToken();
     // HttpRequest req = CreateHttpRequest.createHttpRequest(ApiEndPoint,'GET', 'Bearer ',accessToken);
             //add the request to continuation instance
       System.debug(accessToken);
      
      HttpRequest req = new HttpRequest();
      req.setEndpoint(ApiEndPoint);
      req.setMethod('GET');
      req.setHeader('Authorization','Bearer '+accessToken);
      //we can add upto 3 requests
      System.debug(req);
      requestLabel1 = con.addHttpRequest(req);
      
      //pass the continuation instance to the framework	
    
      System.debug(con);
      return con;
    }
    @AuraEnabled(continuation=true cacheable=true)
    public static Object startExtract(List<String> labels, Object state) {
  
      HttpResponse response = Continuation.getResponse(labels[0]);

      String result = response.getBody();
      System.debug(' startExtract ' +result);
      
      Continuation chainedContinuation = null;
      // Chain continuation if some condition is met
      // 
      // 
      
      System.debug(response.getStatusCode());
      if (response!=null&&response.getStatusCode()==200||response.getStatusCode()==201||response.getStatusCode()==202) {
          // Create a second continuation 
          chainedContinuation = new Continuation(120);
          // Set callback method
          chainedContinuation.continuationMethod='processResponse';
          
          // Create callout request
          String contentDocumentId = (String)state;
          String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
          Authentication auth = new JWTAccessToken();
          String accessToken  = auth.getAccessToken();
           System.debug(accessToken);
          //HttpRequest req = CreateHttpRequest.createHttpRequest(ApiEndPoint,'POST', 'Bearer ',accessToken);
          HttpRequest req = new HttpRequest();
          req.setEndpoint(ApiEndPoint);
          req.setMethod('POST');
          req.setHeader('Authorization','Bearer '+accessToken);
          System.debug(req);
          // Add callout request to continuation
        requestLabel2 = chainedContinuation.addHttpRequest(req); 
      }
      
      // Start another continuation 
      return chainedContinuation;  
      // //Instantiate the Continaution class
      // //Also, pass the timeout when instantiation
      // Continuation con = new Continuation(40);

      // //this is the callback method	
      // con.continuationMethod='processResponse';
      
      // //Data that you want to pass to the callback method
      // con.state='Hello, World!';
      
      // //Create the request
      // String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/'+contentDocumentId+'/ocrDocumentScanResults';
      // Authentication auth = new JWTAccessToken();
      // String accessToken  = auth.getAccessToken();
      // HttpRequest req = CreateHttpRequest.createHttpRequest(ApiEndPoint,'POST', 'Bearer ',accessToken);
      // //add the request to continuation instance
      // //we can add upto 3 requests
      // con.addHttpRequest(req);
      
      
      // //pass the continuation instance to the framework	
      // return con;
    }
    @AuraEnabled(continuation=true cacheable=true)
    public static Object getExtract(String contentDocumentId) {
  
      //Instantiate the Continaution class
      //Also, pass the timeout when instantiation
      Continuation con = new Continuation(40);

      //this is the callback method	
      con.continuationMethod='processResponse';
      
      //Data that you want to pass to the callback method
      con.state='Hello, World!';
      
      //Create the request
      String ApiEndPoint = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v55.0/connect/form-reader/contentDocuments/069RM0000001hHVYAY/ocrDocumentScanResults';
      Authentication auth = new JWTAccessToken();
      String accessToken  = auth.getAccessToken();
      HttpRequest req = CreateHttpRequest.createHttpRequest(ApiEndPoint,'GET', 'Bearer ',accessToken);        
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
  @AuraEnabled(cacheable=true)
  public static Object processChainedResponse(List<String> labels, Object state) {   
      // Get the response for the chained request
      HttpResponse response = Continuation.getResponse(labels[0]);
      // Set the result variable that is displayed on the Visualforce page
      String result= response.getBody();
           
      // Return null to re-render the original Visualforce page
      return result;
    }
}