public class OAuth_Uname_Password {
    public string clientId		{set;get;}
    public string clientsecret  {set;get;}
    public string username 		{set;get;}
    public string password		{set;get;}
    public string accesstoken	{set;get;}
    public string result		{set;get;}
    public string endpoint		{set;get;}
    public string industry		{set;get;}
    public OAuth_Uname_Password(){
        endpoint='https://login.salesforce.com/services/oauth2/token';
    }
    public void send(){
        Http p=new Http();
        Httprequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        string body='grant_type=password';
        body=body+'&client_id='+clientid;
        body=body+'&client_secret='+clientsecret;
        body=body+'&username='+username;
        body=body+'&password='+password;
        request.setBody(body);
        HttpResponse response=p.send(request);
        result=response.getBody();
        system.JSONParser jp =JSON.createParser(result);
        while(jp.nextToken()!= null){
            if(jp.getText()=='access_token'){
                jp.nextToken();
                AccessToken=jp.getText();
            }
        }
    }
    public void invoke(){
        string endpoint='https://solonustechnologiespvtltd2-dev-ed.my.salesforce.com/services/apexrest/createAccount?industry='+industry;
   		Http p = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Authorization','OAuth '+AccessToken);
        HttpResponse response = new HttpResponse();
        result= response.getBody();
        system.debug('result');
    }
}