@isTest
public class ZendeskAPIClass_TestClassController {
    @isTest static void Controllertest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ZendeskAPIClass_TestClass());
        ZenDeskApiClass.getUserResponse('https://vinithtech.zendesk.com','/api/v2/users/me.json','tirumalasettisaikrishna@gmail.com','8712331193');
        Test.stopTest();
    }
}