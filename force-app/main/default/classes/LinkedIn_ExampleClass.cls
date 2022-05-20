public class LinkedIn_ExampleClass {
    public string client_id 	  {set;get;} //86lsnyutq5pwlj
    public string client_secret   {set;get;} //SqQAwPbjBqr9sklo
    public string redirect_uri    {set;get;}
    public string code			  {set;get;}
    public string access_token    {set;get;}
    public string state           {set;get;}
    public string scope			  {set;get;}
    public string result		  {set;get;}
    public LinkedIn_ExampleClass(){
        redirect_uri ='https://solonustechnologiespvtltd2-dev-ed--c.visualforce.com/apex/LinkedIn_Response';
    }
    public pageReference requestCode(){
    string url='https://www.linkedin.com/oauth/v2/authorization';
    url=url+'?response_type=code';
    url=url+'&client_id='+client_id;
    url=url+'&redirect_uri='+redirect_uri;
    url=url+'&state='+state;
    url=url+'&scope='+scope;
    pageReference p = new PageReference(url); 
    return p;
	}
    public void readcode(){
        code=Apexpages.currentPage().getparameters().get('code');
    }
    public void requesttoken(){
        string endpoint='https://www.linkedin.com/oauth/v2/accessToken';
        Http p = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setmethod('POST');
        string body='grant_t ype=authorization_code';
        body=body+'&redirect_uri='+redirect_uri;
        body=body+'&client_id='+client_id;
        body=body+'&client_secret='+client_secret;
        request.setBody(body);
        HttpResponse response= p.send(request);
        string jsonString=response.getbody();
        system.JSONParser jp=JSON.createParser(jsonString);
        while(jp.nextToken()!= null){
            if(jp.getText()=='access_token '){
                jp.nextToken();
                access_token = jp.getText();
            }
        }
      /*  public void getData(){
            string endpoint='https://api.linkedin.com'
        }*/
    }
}