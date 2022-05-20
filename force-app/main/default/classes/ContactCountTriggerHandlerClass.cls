public class ContactCountTriggerHandlerClass 
{
    public static void GetAccCon(List<Contact> contactList)
    {
        Set<Id> accountIdsSet = new Set<Id>();
        /*if ( Trigger.isDelete ) {
            contactList = Trigger.Old; // List<sObject> => List<Contact>
        } else {
            contactList = Trigger.New;
            // Account A
            // Account B
            // A => B on Contact C
        }*/
        for ( Contact con : contactList ) {
            if (con.AccountId != null ){
                accountIdsSet.add(con.AccountId);
            }
            if ( Trigger.isUpdate ) {
                Contact oldContact = (Contact)Trigger.oldMap.get(con.Id); // Map<Id, sObject>
                if ( oldContact.AccountId != con.AccountId ) {
                    accountIdsSet.add(oldContact.AccountId);
                }
            } 
        }
        List<Account> accountList = [Select Id, Contacts_Counter__c, (Select Id From Contacts )
                                    	From Account Where Id IN : accountIdsSet];
        for (Account acc : accountList) {
            if ( acc.Contacts != null ){
                acc.Contacts_Counter__c = acc.Contacts.size();
                system.debug('acc.Contacts_Counter__c==='+acc.Contacts_Counter__c);
            } else {
                acc.Contacts_Counter__c = 0;
            }
        }
        update accountList;  
}
}