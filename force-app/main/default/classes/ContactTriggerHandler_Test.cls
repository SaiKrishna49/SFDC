@isTest(SeeAllData = false)
public class ContactTriggerHandler_Test 
{
    @isTest
    public static void TestMethod1()
    {
        List<Account> accList=new List<Account>{new Account(Name='Test Acc 1'),
            									new Account(Name='Test Acc 2')};
        insert accList;
        list<contact> ConList = new list<contact>();
        for(integer i=0 ; i < 5 ; i++){
            contact con1 = new contact();
            con1.LastName = accList[0].Name +i;
            con1.AccountId = accList[0].Id;
            ConList.add(con1);
            contact con2 = new contact();
            con2.LastName = accList[1].Name +i;
            con2.AccountId = accList[1].Id;
            ConList.add(con2);
        }
        insert ConList;
      /*  for(contact con :ConList ){
            
        }*/
        Account Acclist1 = [SELECT id,Name,Contacts_Counter__c FROM account WHERE Name = 'Test Acc 1' LIMIT 1];
        Account Acclist2 = [SELECT id,Name,Contacts_Counter__c FROM account WHERE Name = 'Test Acc 2' LIMIT 1];
        List<contact> con=[SELECT Id FROM Contact WHERE AccountId=:Acclist1.id  LIMIT 2];
        con[0].AccountId=Acclist2.Id;
        con[1].AccountId=Acclist2.Id;
        UPDATE con[1];
        DELETE con[0];
        UNDELETE con[0];
        Account Acclist3=[SELECT id,Name,Contacts_Counter__c FROM Account WHERE Name='Test Acc 1' LIMIT 1];
        Account Acclist4=[SELECT id,Name,Contacts_Counter__c FROM Account WHERE Name='Test Acc 2' LIMIT 1];
        System.assertEquals(4, Acclist3.Contacts_Counter__c);
        System.assertEquals(5, Acclist4.Contacts_Counter__c);
    }
}