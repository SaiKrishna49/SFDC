/**************************************************************************************************
*** Class Name             : ContactTriggerHandler
*** Class Description      : This class will be invoked when the data is POSTed to API published and
this class routes to specific method based on the events.
*** Author                 : Hari
*** Class Created Date     : 26-May-2020
*** Change Management      :
*           Change #          : User Self-Registration
*           Change Description: Adding the User Self Registration Integration
*           Modified Date     : 02-Sep-2020
*           Modified By       : Hari
**************************************************************************************************
*           Change #          : #2311
*           Change Description: Deprecation of the Enrollments GET API - Docebo Contact Enrollments
*           Modified Date     : 13-Aug-2021
*           Modified By       : Hari
**************************************************************************************************/

/*** Class Name             : ContactTriggerHandler
*** Class Description      : This class is used to count number of contacts in account.
*** Author                 : krishna
*** Class Created Date     : 21-oct-2021

**************************************************************************************************
*           Change #          : #1
*           Change Description: Added a method to work when in contact account name is modified it should 
								change its child contacts also into that acccount which is written for FamilyTriggerHandler.
*           Modified Date     : 11-Nov-2021
*           Modified By       : krishna
**************************************************************************************************/


public class ContactTriggerHandler 
{
    public static void getUpdatedCon(List<contact> newConList , map<id,contact> oldConMap)
    {					
        set<id> accIdSet = new set<id>();
        list<account> AccListToUpdate = new list<account>();
        for(contact c : newConList){
            Contact oldContact = (Contact)Trigger.oldMap.get(oldConMap.values().Id); 
            if ( oldContact.AccountId != c.AccountId ) {
                AccIdSet.add(oldContact.AccountId);
                AccIdSet.add(c.AccountId );
            }
        }
        if(AccIdSet != null){
            for(Account Acc : [SELECT id,Contacts_Counter__c,(SELECT id FROM contacts) FROM Account WHERE id IN:AccIdSet])
            {
                if(Acc != null ){
                    Acc.Contacts_Counter__c = Acc.contacts.size();
                    system.debug('Acc.Contacts_Counter__c in update=='+ Acc.Contacts_Counter__c);
                    Acclisttoupdate.add(Acc);
                } 
            }
        }
        if(Acclisttoupdate.size()  > 0)
        {
            UPDATE Acclisttoupdate;
        }  
    }
    public static void GetAccountContact(list<contact> oldConList)
    {
        set<id> AccIdSet = new set<id>();
        list<account> Acclisttoupdate = new list<account>();
        for(contact con : oldConList){
            AccIdSet.add(con.AccountId);
        }
        if(AccIdSet != null){
            for(Account Acc : [SELECT id,Contacts_Counter__c,(SELECT id FROM contacts) FROM Account WHERE id IN:AccIdSet])
            {
                if(Acc != null ){
                    Acc.Contacts_Counter__c = Acc.contacts.size();
                    system.debug('Acc.Contacts_Counter__c=='+ Acc.Contacts_Counter__c);
                    Acclisttoupdate.add(Acc);
                }
            }     
        }
        if(Acclisttoupdate.size()  > 0)
        {
            UPDATE Acclisttoupdate;
        }  
    }
    public static void updateAccInCon(map<id,contact> newConmap , map<id,contact> OldContMap){
        system.debug('UPDATE updateAccInCon METHOD');
        set<id> conIdset = new set<id>();
        list<contact> contactListToUpdate = new list<contact>();
             for(contact conRec : [SELECT id FROM contact WHERE id IN:newConmap.keyset()]){
                                        system.debug('conRec in for loop=='+conRec);
                              system.debug('conRec.accountId=='+conRec.accountId);          
        /*    if(conRec.accountId != NULL && conRec.accountId != OldContMap.get(conRec.accountId)){
            familyRec.Account__c = familyRec.Contact__r.accountId;
                system.debug('familyRec.Account__c=='+ familyRec.Account__c);
            familyListToUpdate.add(familyRec);
                }
        }
             if(familyListToUpdate.size() > 0){
            UPDATE familyListToUpdate;
            system.debug('familyListToUpdate=='+ familyListToUpdate);
        }*/
    }
    
}
}