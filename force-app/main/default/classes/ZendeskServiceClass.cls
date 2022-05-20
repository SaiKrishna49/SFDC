public class ZendeskServiceClass {

  public class Response {
    public Integer code {get;set;}
    public String body {get;set;}
    public Boolean success {get;set;}
    public String errorText {get;set;}
    public String createdZendeskCustomerId {get;set;}

    public Response(Integer code, String body) {
        this.code = code;
        this.body = body;
        this.success = code >= 200 && code < 300; 
    }
  }
  
  public static Response ZendeskCallout() {
      Response resp;
      String method = 'GET';
      if(Limits.getCallouts() >= Limits.getLimitCallouts()) {
          resp.errorText = 'Maximum number of callouts has been reached.';
      } 
      else {
          HttpRequest req = new HttpRequest();
          HttpResponse res = new HttpResponse();
          Http h = new Http();                                 
          req.setEndpoint('https://solunusinchelp.zendesk.com/api/v2/groups.json?apikey=c33cfaeaccebeb68b4ca30b7b13e37bb35177e1ab626aaf19a911271789ed282');
          req.setMethod(method); 
          req.setTimeout(120000); 
          req.setHeader('Accept', '*/*');
          req.setHeader('Content-Type', 'application/json');
          req.setHeader('Connection', 'keep-alive');
          try {
              res = h.send(req);
              system.debug(res);
              system.debug(res.getBody());
              resp = new Response(res.getStatusCode(), res.getBody());
              if(resp.success) {
               //   Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                 system.debug('sucess='+ res.getBody());
              }  
          } catch(Exception ex) {
              resp.errorText = 'An exception has een encountered while callout out to Integration: ' + ex.getMessage();
          }
      }
      return resp;
  }
}



/*
 * 
 * https://gist.github.com/nickforce/44ff97445c15e01f03342815ea18056b
 * 
 * ZendeskService.ZendeskCallout();
 * */