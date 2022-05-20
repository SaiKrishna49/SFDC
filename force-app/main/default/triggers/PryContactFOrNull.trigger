trigger PryContactFOrNull on Contact (after insert, after update) {
/*List<Contact> conlist = new List<Contact>();
    set<Id> accIdSet = new set<Id>();
    Set<Id> ContactIds = new Set<Id>();
    
    if(Trigger.Isinsert){
        system.debug('Trigger.isupdate');
        for ( Contact c : trigger.new ){
            if((c.AccountId != null) && (!c.Primary_Contact__c) ){
                accIdSet.add(c.AccountId); 
            }
            Contact oldcon = Trigger.oldMap.get(c.Id);       
            if(oldcon.id != null)
                ContactIds.add(oldcon.id);
            system.debug('ContactIds==>'+ ContactIds);
            
        }
        conlist=[select id, name,Account.name,Primary_Contact__c from Contact where AccountId IN : accIdSet AND ID NOT IN : ContactIds];
        
        system.debug('conlist=on prycontactfornull=>'+conlist);
        
        list<account> acclist = [select id,name,Primary_Contact__c from account where id IN:accIdSet];
       system.debug('acclist=on prycontactfornull='+ acclist);
}*/
}