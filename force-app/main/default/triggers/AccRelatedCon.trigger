trigger AccRelatedCon on Contact (After insert, After delete, After undelete) {
    Set<Id> AccIdsSet = new Set<Id>();
    List<Account> accListToUpdate = new List<Account>();
    IF(Trigger.IsAfter){
        IF(Trigger.IsInsert || Trigger.IsUndelete){
            FOR(Contact con : Trigger.new){
                if(con.AccountId!=null){   
                   AccIdsSet.add(con.AccountId); 
                }
            }
        }
        IF(Trigger.IsDelete){
            FOR(Contact con : Trigger.Old){
                if(con.AccountId!=null){   
                   AccIdsSet.add(con.AccountId); 
                }
            }
        }
    }
    System.debug('AccIdsSet === '+AccIdsSet);
    List<Account> accList = new List<Account>([Select id ,Name, Number_of_Contacts__c, (Select id, Name From Contacts) from Account Where id in:AccIdsSet]);
    FOR(Account acc : accList){
        List<Contact> contactList = acc.Contacts;
        acc.Number_of_Contacts__c = contactList.size();
        accListToUpdate.add(acc);
    }
    update accListToUpdate;
}   











 /*   set<id> AccIdset = new set<id>();
    for(contact con: trigger.new){
        system.debug('trigger.new=='+trigger.new);
        AccIdset.add(con.Accountid);
        system.debug('AccIdset=='+ AccIdset);
    }
    list<Account> AccList = [SELECT ID,number_of_contacts__c,(select Id,AccountId FROM contacts) From Account WHERE ID IN:AccIdset];
    system.debug('AccListAccList=='+ AccList);
    for(Account Act: AccList){
        Act.number_of_contacts__c = Act.contacts.size();
        system.debug('AccList.size();=='+ Act.contacts.size());
    }
    update AccList;
    system.debug('AccList=='+ AccList);
}*/