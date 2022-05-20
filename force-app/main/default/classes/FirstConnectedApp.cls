@RestResource(urlMapping='/getaccInfo/*')
global class FirstConnectedApp {
    @HttpGet
    global static account getaccrec(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string urlId = req.requestURI.subString(req.requestURI.lastIndexof('/')+1);
        Account AccList = [SELECT id,Name,Type,Phone,Industry,BillingAddress FROM Account where Id =: urlId];
        return AccList;
    }
    @HttpPost
    global static string postAccRec(){
        Account acc = new Account();
        acc.Name = 'name';
        acc.Phone = 'phone';
        acc.Website = 'website';
        INSERT acc;
        RETURN acc.Id;
    }

}