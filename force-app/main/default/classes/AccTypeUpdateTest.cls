@istest
public class AccTypeUpdateTest {
  
    public static testmethod void AfterUpdateTest(){
       Account Acc = new Account();
       Acc.Name='Test Acc 1';
        Acc.Type = 'Prospect';
        insert Acc;
     Insert(new  List<Contact>{new Contact(LastName='shaif',email='shaiksaif@gmail.com',AccountId=acc.Id),
                     new Contact(LastName='shai1',Accountid=acc.Id)} );
       
              Acc.Type = 'Customer - Direct';
        update Acc;
          }

}