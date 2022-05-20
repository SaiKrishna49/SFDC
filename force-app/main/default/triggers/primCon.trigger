trigger primCon on Contact ( before update, before insert,after insert, after update) {
    List<Id> accounts=new List<Id>();
    system.debug('accounts='+accounts);
    for(contact c: Trigger.New){
        if( c.AccountId!=Null)
            accounts.add(c.AccountId);
        system.debug('accounts in for loop=='+ accounts);
        
    }
    List<contact> contacts= [select id, Primary_contact__c,(select id,Primary_contact__c,name from accounts__r) from contact WHERE AccountId IN:accounts];
    system.debug('contacts list=='+ contacts);
    
    for(contact c:trigger.New){
        if(c.Primary_contact__c==true){
            for(contact con: contacts){
                con.Primary_contact__c=false;
                
                
            }
            update contacts;
            system.debug('contacts updated=='+ contacts);
        }
        
    }
}