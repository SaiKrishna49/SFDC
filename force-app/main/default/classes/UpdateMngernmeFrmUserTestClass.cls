@istest
public class UpdateMngernmeFrmUserTestClass {
@istest
    public static void updateManagertest(){
        list<user> usrlist = new list<user>();
        user usrRec = new user();
        for(user userRec : [SELECT id,name,managerId FROM user]){
             userRec.ManagerId = '2 user';
            usrlist.add(userRec);
        }
       
        test.startTest();
        UPDATE usrlist;
        test.stopTest();
    }
}