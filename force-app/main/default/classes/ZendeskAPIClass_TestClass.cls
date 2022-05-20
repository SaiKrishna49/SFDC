@isTest
global class ZendeskAPIClass_TestClass implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://vinithtech.zendesk.com/api/v2/users/me.json', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }
}