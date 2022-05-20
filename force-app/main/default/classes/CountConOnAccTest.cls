@isTest(SeeAllData = false)
private class CountConOnAccTest 
{
     static testMethod void CountConOnAccTestMethod1(){
        Account acc = new Account();
        acc.Name = 'Test Acc 1';
        insert acc;
        
        Contact con1 = new Contact();
        Con1.lastName = 'con 1';
        con1.AccountId = Acc.id;
        
        
        Contact con2 = new Contact();
        Con2.lastName = 'con 2';
        con2.AccountId = Acc.id;
        
        Contact con3 = new Contact();
        Con3.lastName = 'con 3';
        con3.AccountId = Acc.id;
        
         Test.startTest();
            insert con1;
            insert con2;
            Insert con3;
            delete con1;
            Update con2;
        Test.StopTest();
    }
}















/*
 * 
 * 
 * 
 * 
 * 
 * 
 *  public static void contactUpdateRecords(map<id,contact> newMap, map<id,contact> oldMap)
    {

        set<id> accountids=new set<id>();
        set<id> keys=oldMap.keyset();
        for(id k: keys)
        {
            contact oldValue =oldMap.get(k);
            contact newValue =newMap.get(k);
            if(oldValue.AccountId != newValue.AccountId)
            {
                accountids.add(oldValue.AccountId);
                accountids.add(newValue.AccountId);
            }
            else
            {
                accountids.add(newValue.AccountId);
            }
        }

        list<account> accolist = new list<account> ();
        list<account> acc=[SELECT id,Number_of_Contacts__c,(SELECT id,lastname,firstName FROM contacts)
                           FROM account WHERE id in:accountids];                  

        for(account a: acc)
        {
            a.Number_of_Contacts__c=a.contacts.size();
            accolist.add(a);
        }

        update accolist ;

    }
*/