public class Zendesk {
    public static void getUserResponse(String subdomain,String Path, String username, String password){
        try{
            String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(Blob.valueOf(username + ':' + password));
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(subdomain+Path);
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', authorizationHeader);
            HttpResponse res =  http.send(request);
            System.debug('response Code '+res.getStatusCode());
            if(res.getStatusCode() == 200)
            {
                System.debug('response ='+res.getBody());
                string jsonString = '['+res.getBody()+']';
                system.debug('jsonString='+jsonString);
                Attachment attachment = new Attachment();
                attachment.Body = Blob.valueOf(res.getBody()) ;
                attachment.Name = 'ZenDeskApiClass.JSON';
                attachment.ParentId = '0012y000006ub5OAAQ';
                insert attachment;
                system.debug('Attachment'+attachment);
              
            }
      }
        catch(Exception e){
             system.debug('Exception ='+ e.getMessage());
        }
    }
}





/*
 * 
 * 
 * public class ZenDeskApiClass {
    @future(callout = true)
    public static void getUserResponse(String jsonString){
        try{
            List<Integration__c> newRecList = (List<Integration__c>)JSON.deserialize(jsonString,List<Integration__c>.class);
            set<id> IntegrationIdSet = new set<id>();
            for(Integration__c Integrationrec : newRecList){
                IntegrationIdSet.add(Integrationrec.id);
                system.debug('IntegrationIdSet=='+IntegrationIdSet);
            }
            system.debug('IntegrationIdSet.size()='+IntegrationIdSet.size());
            if(IntegrationIdSet.size()> 0){
                for(Integration__c Intrec : [SELECT id,name,subdomain__c,Path__c,username__c,password__c FROM Integration__c Where id In :IntegrationIdSet]){
                    system.debug('Intrec=='+Intrec);
                    system.debug('Intrec.username__c='+Intrec.username__c);
                    system.debug('Intrec.password__c='+Intrec.password__c);
                    String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(Blob.valueOf(Intrec.username__c + ':' + Intrec.password__c));
                    system.debug('authorizationHeader=='+authorizationHeader);
                    Http http = new Http();
                    HttpRequest request = new HttpRequest();
                    request.setEndpoint(Intrec.subdomain__c+Intrec.Path__c);
                    system.debug('Intrec.subdomain__c+Intrec.Path__c=='+Intrec.subdomain__c+Intrec.Path__c);
                    request.setMethod('GET');
                    request.setHeader('Content-Type', 'application/json');
                    request.setHeader('Authorization', authorizationHeader);
                    HttpResponse res =  http.send(request);
                    System.debug('response Code '+res.getStatusCode());
                    if(res.getStatusCode() == 200)
                    {
                        System.debug('response ='+res.getBody());
                        string jsonStringResponse = '['+res.getBody()+']';
                        system.debug('jsonStringResponse='+jsonStringResponse);
                        Attachment attachment = new Attachment();
                        attachment.Body = Blob.valueOf(res.getBody()) ;
                        attachment.Name = 'ZenDeskApiClass.JSON';
                        attachment.ParentId = Intrec.Id;
                        insert attachment;
                        system.debug('Attachment'+attachment);
                    }
                }
            }
        }
        catch(Exception e){
            system.debug('Exception ='+ e.getMessage());
        }
    }
}
*/