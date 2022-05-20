/**************************************************************************************************
*** Class Name             : FoodRecipieAPIClass_TestClass
*** Class Description      : This Test class is used to test FoodRecipieAPIClass.
*** Author                 : Krishna
*** Class Created Date     : 11-Nov-2021
**************************************************************************************************/

@isTest
global class FoodRecipieAPIClass_TestClass implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://api.spoonacular.com/recipes/random?apiKey=f8ad8a32c97c4993a81dfb7515495556', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }
}