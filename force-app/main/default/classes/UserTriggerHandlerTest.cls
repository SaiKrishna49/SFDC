@istest
public class UserTriggerHandlerTest {
    @istest
    static void userPSetTestmethod() {
        User userRec = new user(alias = 'test123', email='test123@gemail.com',
                                emailencodingkey='UTF-8', firstName='Test', lastname='Testing', languagelocalekey='en_US',
                                localesidkey='en_IN', profileid = '00e5g000000M0KqAAK', country='India',
                                timezonesidkey='Asia/Kolkata', username='t8456321uy@gmail.com');
        test.startTest();
        INSERT userRec;
        system.assertEquals('00e5g000000M0KqAAK', userRec.ProfileId);
        test.stopTest();
    }
    
}




 /* Id profileid = [select id from profile where Name = 'System Administrator'][0].id;
        PermissionSet ps = new PermissionSet(Name = 'Support_Community', Label = 'Support Community Access');
        insert ps;
        PermissionSetGroup psg = new PermissionSetGroup(DeveloperName = 'Test_Group', MasterLabel = 'Test Group');
        insert psg;
////
    for(PermissionSetAssignment psa:[SELECT Id, PermissionSetId, PermissionSet.Name, PermissionSet.ProfileId, PermissionSet.Profile.Name, AssigneeId, Assignee.Name FROM PermissionSetAssignment WHERE AssigneeId =:+ userRec.id ]){
            PermissionSetAssignment assignPermissionset = new PermissionSetAssignment();
                    assignPermissionset.PermissionSetGroupId = psa.Id;
                  
                    //permission set group  assigned name is "group1"
                    assignPermissionset.AssigneeId = psa.Id;
            psalist.add(assignPermissionset);
///


*/