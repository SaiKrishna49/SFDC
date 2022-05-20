public class ZenDeskApiClass {
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
                Attachment attachment = new Attachment();
                attachment.Body = Blob.valueOf(res.getBody());
                attachment.Name = 'ZenDeskApiClass.csv';
                attachment.ParentId = '0015g00000hbGISAA2';
                insert attachment;
                system.debug('Attachment'+attachment);
                string jsonString = '['+res.getBody()+']';
                system.debug('jsonString='+jsonString);
                 JsonToCSVUtility.getCSVString(jsonString);
                //JsonToCSVUtility.getCSVString(jsonString);
                 List<Object> entryList = (List<Object>) JSON.deserializeUntyped(jsonString);
                system.debug('entryList='+entryList);
                List<Map<String, Object>> mapList = new List<Map<String, Object>>();
                Set<String> keySet = new Set<String>();
                
                for (Object entry : entryList) {
                    system.debug('entry='+ entry);
                    Map<String, Object> m = (Map<String, Object>)(entry);
                    keySet.addAll(m.keySet());
                    mapList.add(m);
                    system.debug('m='+ m);
                    system.debug('keySet='+ keySet);
                }
                
                List<String> keys = new List<String>(keySet);
                system.debug('keys='+ keys);
                keys.sort();
                system.debug('keys.sort()='+keys);
                
              
            }
      }
        catch(Exception e){
            system.debug('Exception ='+ e.getdmlmessage(0));
        }
    }
}








/*To call:
 * ZenDeskApiClass.getZendeskResponse('https://vinithtech.zendesk.com/api/v2/users/me.json','tirumalasettisaikrishna@gmail.com','8712331193');
Api Key:
 * aaa795e17ee2fef91e93431d9e19c5b6c7ef6e89039c06a7bcdb45b415540b26
 * Users:
 * https://vinithtech.zendesk.com/api/v2/users/me.json
 * Req = '/api/v2/users/me.json'
 * Tickets:
 * https://vinithtech.zendesk.com/api/v2/tickets
 * req= /api/v2/tickets
 * Recent Tickets:
 * https://vinithtech.zendesk.com/api/v2/tickets/recent
 * All users:
 *  https://vinithtech.zendesk.com/api/v2/users
 * Req= /api/v2/users
 * Tickets include comment:
 * https://vinithtech.zendesk.com/api/v2/tickets.json?include=comment_count
# Set the request parameters
url = 'https://your_subdomain.zendesk.com/api/v2/groups.json' ==> https://solunusinchelp.zendesk.com/api/v2/users/me.json
user = 'your_email_address'
pwd = 'your_password'
vinithtech
# Do the HTTP get request
response = requests.get(url, auth=(user, pwd))

# Check for HTTP codes other than 200
if response.status_code != 200:
    print('Status:', response.status_code, 'Problem with the request. Exiting.')
    exit()


endpoint== 
https://solunusinchelp.zendesk.com/api/v2/groups.json?apikey=1786bcebbb6597b3f45a778c611ba15817132fc555b02268e3c38317f929fbd4

'https://solunusinchelp.zendesk.com/api/v2/groups.json/tirumalasettisaikrishna@gmail.com/token:1786bcebbb6597b3f45a778c611ba15817132fc555b02268e3c38317f929fbd4');

https://solunusinchelp.zendesk.comtirumalasettisaikrishna@gmail.com8712331193



 public static string url = 'https://solunusinchelp.zendesk.com/api/v2/users/me.json';
    public static string email = 'tirumalasettisaikrishna@gmail.com';
    public static string pword = '8712331193';
    public String namedCredential;
    public String subdomain;
    public String username;
    public String password;
    public String apiToken;
    public String oauthToken;




/*  JSON to CSV conversion
                string s = '['+res.getBody()+']';
                system.debug('s='+s);
                List<Object> entryList = (List<Object>) JSON.deserializeUntyped(s);
                system.debug('entryList='+entryList);
                List<Map<String, Object>> mapList = new List<Map<String, Object>>();
                Set<String> keySet = new Set<String>();
                
                for (Object entry : entryList) {
                    system.debug('entry='+ entry);
                    Map<String, Object> m = (Map<String, Object>)(entry);
                    keySet.addAll(m.keySet());
                    mapList.add(m);
                    system.debug('m='+ m);
                    system.debug('keySet='+ keySet);
                }
                
                List<String> keys = new List<String>(keySet);
                system.debug('keys='+ keys);
                keys.sort();
                system.debug('keys.sort()='+keys);
                /*
                List<List<String>> csvLines = new List<List<String>>();
                
                for (Integer i = 0; i <= mapList.size(); i++) {
                    csvLines.add(new List<String>());
                }
                
                for (String key : keys) {
                    csvLines.get(0).add('"' + key + '"');
                    
                    for (Integer i = 1; i <= mapList.size(); i++) {
                        csvLines.get(i).add('"' + (String)(mapList.get(i - 1).get(key)) + '"');
                    }
                }
                
                String csvFile = '';
                for (List<String> csvLine : csvLines) {
                    String line = '';
                    for (Integer i = 0; i < csvLine.size() - 1; i++) {
                        line += csvLine.get(i) + ',';
                    }
                    line += csvLine.get(csvLine.size() - 1);
                    csvFile += line + '\n';
                    system.debug('csvFile='+ csvFile);
                  /*  Attachment attachment = new Attachment();
                attachment.Body = Blob.valueOf(csvFile) ;/*Blob.valueOf(res.getBody());
                attachment.Name = 'ZenDeskApiClass.csv';
                attachment.ParentId = '0015g00000cBc2eAAC';
                insert attachment;
                system.debug('Attachment'+attachment);
               
                } */