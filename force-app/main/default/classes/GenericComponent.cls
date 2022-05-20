public class GenericComponent {
    public static void genericMethod(String url,String reqType,string value){
        HTTP callout=new HTTP();
        HTTPRequest request=new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod(reqType);
        request.setHeader('content-type',value);
        Httpresponse calloutresponse=callout.send(request);
        string response=calloutresponse.getBody();
        System.debug(response);
        Attachment att=new Attachment();
        att.Body=Blob.valueOf(response);
        att.Name='Indian post api.csv';
        att.ParentId='0015g000003Eg3NAAS';
        insert att;
    }
    
}