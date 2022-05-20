public class CountConOnAccClass 
{
    public static void GetAccContacts(List<contact> newcontactlist,List<contact> oldcontactlist){
        set<id> accidset= new set<id>();
        if(newcontactlist !=null){
            for(Contact c:newcontactlist){
                if(c.AccountId!=null){
                    accidset.add(c.accountid);
                }
            }      
        }
        if(oldcontactlist!=null){
            for(Contact c:oldcontactlist){
                accidset.add(c.accountid);
                if ( Trigger.isUpdate ) {
                
                    Contact oldContact = (Contact)Trigger.oldMap.get(c.Id); 
                    if ( oldContact.AccountId != c.AccountId ) {
                        accidset.add(oldContact.AccountId);
                    }
                
            }
            }
            
        }
        List<Account> accList = new list<Account>();
        if(accList.size() > 0){
            for(Account acc :[SELECT id, Contacts_Counter__c,(SELECT id FROM Contacts) FROM Account WHERE id IN: accidset]){
                
                acc.Contacts_Counter__c = acc.Contacts.size();
                system.debug('Contacts Related to account == '+ acc.Contacts.size()); 
                accList.add(acc);
            }
        } 
        if(accList.size() > 0){
            update accList;
        }
    } 
    
}









/* */