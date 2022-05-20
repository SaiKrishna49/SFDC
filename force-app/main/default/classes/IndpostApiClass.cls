/**************************************************************************************************
*** Class Name             : IndpostApiClass
*** Class Description      : This class will be invoked when the data is given for the IndianPostAPI, 
								the generated Json is converted to CSV file and adding to record as an attachment.
*** Author                 : Krishna
*** Class Created Date     : 10-JAN-2022
**************************************************************************************************/

public class IndpostApiClass {
    
    public static void getPostalDetails(String url,String reqType,string value){
        HTTP callout=new HTTP();
        HTTPRequest request=new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod(reqType);
        request.setHeader('content-type',value);
        Httpresponse calloutresponse=callout.send(request);
        System.debug('response Code== '+calloutresponse.getStatusCode());
        if(calloutresponse.getStatusCode() == 200){
            string response=calloutresponse.getBody();
            System.debug(response);
            Attachment att=new Attachment();
            att.Body=Blob.valueOf(response);
            att.Name='Indian post api.csv';
            att.ParentId='0015g00000bU9JcAAK';
            insert att;
            
        }
        
    }
}






/*
 * IndpostApiClass.getPostalDetails('https://api.postalpincode.in/pincode/522111','GET','JSON');
 * */