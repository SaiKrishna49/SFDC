public class PrimaryContactOnInsert {
    
    public static void ContactOnInsert(List<Contact> contactList){
        Set<Id> accountIdSet = new Set<Id>();
        Map<Id,Contact> accountIdContactMap = new Map<Id,Contact>();
        system.debug('contactList=='+contactList);
        for(Contact contactObj:contactList){
            if(contactObj.Primary_Contact__c==true && contactObj.AccountID!=null){               
                accountIdSet.add(contactObj.AccountID);
            }
        }
system.debug('accountIdSet=='+ accountIdSet);
system.debug('accountIdSet.size--'+accountIdSet.size());
        if(accountIdSet!=null && accountIdSet.size()>0){            
            //Preparation of map accountIdContactMap for existing primary contact
            for(Contact contObj:[select id,Primary_Contact__c,AccountId from Contact 
                                 where AccountId in:accountIdSet and Primary_Contact__c=true]){
                                     accountIdContactMap.put(contObj.AccountId,contObj);
                                 }
system.debug('accountIdContactMap==='+ accountIdContactMap);
            //validation starts
            for(Contact contactObj:contactList){
                if(contactObj.Primary_Contact__c==true && contactObj.AccountID!=null
                   && accountIdContactMap.get(contactObj.AccountId)!=null){
                      // contactObj.addError('You can\'t create more than one primary contact.');
system.debug('accountIdContactMap.get(contactObj.AccountId)=='+accountIdContactMap.get(contactObj.AccountId));
system.debug('contactObj.Primary_Contact__c==true=='+contactObj.Primary_Contact__c);
contactObj.Primary_Contact__c = false;
UPDATE contactObj;
                   }                       
            }
        }
        
        
    }
    
}