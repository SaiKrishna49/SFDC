public class TwitterListApi
{
    //List<String> list_name= new List<String>();
    //List<Companies> list_com;
    
    public String oAuthConsumerKey = 'BlsoC839h5czptk6oHyyAgTGq';
    public String oAuthConsumerSecret = 'iAF4rc2AFEOP1h9rNVx4ZM8B86GXo4IGPcl2DN67iiMi6mdxnu';
    public String oAuthUrl = 'https://api.twitter.com/oauth2/token';
    public String oAuthUrl_1 = 'https://api.twitter.com/1.1/users/lookup.json?screen_name=';
    /*public String username{get;set;}
    public String location{get;set;}
    public String mobile{get;set;}
    public String screenname{get;set;}*/
    public String username;
    public String location;
    public String mobile;
    public String screenname;
    public String stoken;
    public List<Companies> list_com{get;set;}
           
     
    public pageReference Submit()
    {
        pageReference pageRef= new pageReference('/apex/GenerateListApi');
        //pageRef.setRedirect(true);
        pageRef.setRedirect(false);
        return pageRef;
    }
    
    public void generatecsv()
    {
        list_com=new List<Companies>();
         String name;
        //List<String> list_name= new List<String>();
        List<username__c> list_user;
        try
        {
            list_user=[select Name from username__c];
        }
        catch (System.QueryException e)
        {
            system.debug('Error in generatecsv method for list_user query** '+e);
        }
        for (username__c user:list_user)
        {  
           if (name==null)
           {
               //name=user.name__c;
               String url=EncodingUtil.urlEncode(user.Name,'UTF-8');
               //list_name.add(name);
               name=url;               
           }
           else 
           {
               String url=EncodingUtil.urlEncode(user.Name,'UTF-8');
               name=name+','+url;
           }
        }
        system.debug('name** '+name);
        //Encode them
        String keyencoded = EncodingUtil.urlEncode(oAuthConsumerKey, 'UTF-8');
        String secretkeyencoded = EncodingUtil.urlEncode(oAuthConsumerSecret, 'UTF-8');

        //Create Final Key String
        String sFinal = keyencoded + ':' + secretkeyencoded;
        //Convert to Blob
        Blob headerValue = Blob.valueOf(sFinal);
        system.debug('headerValue** '+headerValue);

        //Build Request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(oAuthUrl);
        req.setMethod('POST');

        //Add Auth Header
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        system.debug('authorizationHeader** '+authorizationHeader);

        //You need to add this to the request - proved easy to miss in instructions...
        req.setBody('grant_type=client_credentials');

        //Make request
        Http http = new Http();
        try{
        HTTPResponse res = http.send(req);
        system.debug('Body_1** '+res.getBody());           
        //String stoken;
        //Parse JSON for Bearer Token
        
        JSONParser parser = JSON.createParser(res.getBody());
        while (parser.nextToken() != null) {
        if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'access_token'){
        parser.nextToken();
        stoken = parser.getText();
        }
        }
        }
        catch(System.CalloutException e)
        {
            system.debug('Error_1** '+e.getMessage());
        }
        
     
    HttpRequest req2 = new HttpRequest();
    //I actually store the endpoint in the same custom setting and build dynamically, but for purposes of demo:
    //req2.setEndpoint(oAuthUrl_1 + screenname);
    //system.debug(oAuthUrl_1 + screenname);
    req2.setEndpoint(oAuthUrl_1 + name);
    req2.setMethod('GET');

    //Call Bearer token Method
    //Note - unless invalidated, I believe you can store this and keep using it indefinitely, but again, to demo concept
    String authorizationHeader_1 = 'Bearer ' + stoken;
    req2.setHeader('Authorization', authorizationHeader_1);
    system.debug('authorizationHeader_1** '+ authorizationHeader_1);

    //Http http = new Http();
    try{
    HTTPResponse res = http.send(req2);
    String sBody = res.getBody();
    system.debug('Body_2** ' + sBody);
    boolean success=true;
    //List<Companies> list_com=new List<Companies>();
    
    JSONParser parser=JSON.createparser(res.getBody());
    while (parser.nextToken()!=null)
    {
        if(parser.getCurrentToken()== JSONToken.START_OBJECT)
        {    
            while (parser.nextToken()!=null)
            {
                if((parser.getCurrentToken()==JSONToken.FIELD_NAME) && (parser.getText()=='screen_name'))
                {
                    parser.nextToken();
                    screenname=parser.getText();
                    system.debug('screenname** '+screenname);
                    success=true;
                }
                system.debug('screenname1** '+screenname);
                if((parser.getCurrentToken()==JSONToken.FIELD_NAME) && (parser.getText()=='name')) 
                {
                    parser.nextToken();
                    username=parser.getText();
                    system.debug('username** '+username);
                }
                
                //integer i = 0;
                
                if((parser.getCurrentToken()==JSONToken.FIELD_NAME) && (parser.getText()=='location'))
                {
                    parser.nextToken();
                    location=parser.getText();
                    system.debug('location** '+location );
                    //if ((location!=null) || (location!=''))
                    //if isNotBlank(location)
                    if (location!='')
                    {
                        String[] result=location.split(',\\s*');
                        location='"'+result[0]+'"'+' '+result[1];
                    }
                    //location='/'+'abc, abc'+'/';
                    //location = '"'+location+'"';
                    //system.debug('location** '+location );
                }
                
                if (success)
                {
                    if ((parser.getCurrentToken()==JSONToken.FIELD_NAME) && (parser.getText()=='description'))
                    {
                        parser.nextToken();
                        mobile=parser.getText();
                        success=false;
                        system.debug('mobile** '+mobile);
                        system.debug('screenname2** '+screenname);
                      
                        Companies com=new Companies(screenname, username, location, mobile);
                        com.screenname=screenname;
                        system.debug('com** '+com);
                        //List<Companies> list_com=new List<Companies>();
                        list_com.add(com);
                        system.debug('list_com-1*=========================* '+list_com);
                    }
                 }
                 
                 /*if(parser.getCurrentToken()==JSONToken.END_OBJECT)
                 {
                     Companies com=new Companies(screenname, username, location, mobile);
                     system.debug('com** '+com);
                     //List<Companies> list_com=new List<Companies>();
                     list_com.add(com);
                     system.debug('list_com-1** '+list_com);
                 }*/
            }
        }
    }
    }
    catch(System.CalloutException e)
    {
        system.debug('Error_2** '+e.getMessage());
    }
       /*List<Companies> list_com=new List<Companies>();
        Companies com=new Companies(screenname, username, location, mobile);
        system.debug('com** '+com);
        //List<Companies> list_com=new List<Companies>();
        list_com.add(com);
        system.debug('list_com-1** '+list_com);*/
       
    }
    
    public List<Companies> getlistVal()  { 
    
    system.debug('===============list_com============'+list_com); 
                     
        return list_com;
    }
    
    public class Companies
    {
        public String screenname{get;set;}
        public String username{get;set;}
        public String location{get;set;}
        public String mobile{get;set;}
        
       
        
        
        public  Companies(String screename, String username, String location, String mobile)
        {
             this.screenname=screenname;
             this.username=username;
             this.location=location;
             this.mobile=mobile;   
        }
    }
}


/*
 * https://developer.salesforce.com/forums/?id=906F0000000BPwiIAG
 * */