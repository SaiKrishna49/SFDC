trigger primaryContact on Contact (after insert,after update) {
    List<Contact> contactlist = new List<Contact>();
    list<account> acclist = new list<account>();
    set<Id> accIdSet = new set<Id>();
    Set<Id> ContactIds = new Set<Id>();
    if(Trigger.IsUpdate){
system.debug('update');
        for ( Contact c : trigger.new ){
            if(c.AccountId != null)
                accIdSet.add(c.AccountId);   
            Contact oldcon = Trigger.oldMap.get(c.Id);       
            if(oldcon.id != null)
                ContactIds.add(oldcon.id);
            
        }
        
        contactlist = [select id, name,Account.name,Primary_Contact__c from Contact where AccountId IN : accIdSet AND Id NOT IN : ContactIds];
        
        system.debug('contactlist====>'+contactlist);
        
        list<account> acclist = [select id,name,Primary_Contact__c from account where id IN:accIdSet];
        system.debug('acclist=='+ acclist);
        Contact c1=new Contact();
        
        if(checkRecursive.runOnce()){
            for ( Contact c : Trigger.new)
                
            {         
                if(c.Primary_Contact__c ==true)
                {
                    for(Contact a :contactlist)
                    {
                        a.Primary_Contact__c =false;
                        c1=a;
                        for(account acc:acclist){
                            acc.Primary_Contact__c= c.id;
                        }
                        
                    }
                    
                    update c1; 
                    system.debug('updated c1==>'+ c1);
                } else
                    if(c.Primary_Contact__c == false){
                        for(account acc:acclist){
                            acc.Primary_Contact__c= null;
                        }
                    }
                
            }
            update contactlist;
            system.debug('contactlist===>'+ contactlist);
            update acclist;
            system.debug('acclist===>'+ acclist);
        }
    }  
    
    if(Trigger.isInsert){
        for ( Contact c : trigger.new ){
            if(c.AccountId != null)
                accIdSet.add(c.AccountId);   
            Contact oldcon = Trigger.newMap.get(c.Id);       
            if(oldcon.id != null)
                ContactIds.add(oldcon.id);
            
        }
        
        contactlist=[select id, name,Account.name,Primary_Contact__c from Contact where AccountId IN : accIdSet AND Id NOT IN : ContactIds];
        
        system.debug('contactlist===>'+contactlist);
        list<account> acclist = [select id,name,Primary_Contact__c from account where id IN:accIdSet];
        system.debug('acclist=='+ acclist);
        List<Contact> conlist=new List<Contact>();
        Contact c1=new Contact();
        
        if(checkRecursive.runOnce()){
            for ( Contact c : Trigger.new)
            {      
                if(c.Primary_Contact__c ==true)
                {
                    for(Contact a :contactlist)
                    {
                       /* if(a.Primary_Contact__c == true){
                            c.Primary_Contact__c = true;
c=a;
                        }*/
                       a.Primary_Contact__c =false;
                        c1=a;  
                        for(account acc:acclist){
                            acc.Primary_Contact__c= c.id;
                            system.debug('acc.Primary_Contact__c in insert ==>'+ acc.Primary_Contact__c);
                        }
                    }
                    update c1; 
                    system.debug('updated c1 in insert trigger===>'+ c1);
                }  
                
            }
            update contactlist;
            system.debug('contactlist in insert trigger==>'+ contactlist);
            update acclist;
            system.debug('acclist in insert trigger==>'+ acclist);
        }
    }
}