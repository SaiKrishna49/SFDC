trigger PryConOnAccount on Account (After Insert, After Update)
{
    set<id> accNull = new set<id>();
    set<id> connull = new set<id>();
    set<id> conids = new set<id>();
    List<Contact> contactList = new List<Contact>();
    list<account> comacc = new list<account>();
    set<id> accids = new set<id>();
    if(trigger.isAfter && (trigger.isupdate || trigger.isinsert))
    {
        for(account acc : trigger.new)
        {
            if(acc.Primary_Contact__c != null)
            {
                conIds.add(acc.Primary_Contact__c);
                accids.add(acc.Id);
                comacc.add(acc);   
            }
            if(acc.Primary_Contact__c == null)
            { 
                accNull.add(acc.Id);
                system.debug('accNull=='+ accNull);   
            }  
        }   
    }
    list<contact> allrelatedcontacts = [Select Id,Primary_Contact__c, (Select Id, Primary_Contact__c 
                                                                       FROM accounts__r WHERE Primary_Contact__c !=null AND Id !=: accids)
                                        FROM contact WHERE Id =: conIds];
    system.debug('allrelatedcontacts from contact list=='+ allrelatedcontacts);
    for(Account acc: [SELECT Id,(SELECT Id,Primary_Contact__c FROM Contacts) FROM Account WHERE Id in: Trigger.new]){
            If(acc.Contacts.size()>0){
                contactList.addAll(acc.Contacts);
            }
    for(account a: trigger.new){
        if(a.Primary_Contact__c != null ){
            for(integer i=0 ; i < allrelatedcontacts.size() ; i++ ){
                system.debug('allrelatedcontacts.size()=='+allrelatedcontacts.size());
                allrelatedcontacts[i].Primary_Contact__c = true ;
            }
        }else
            if((a.Primary_Contact__c == null) || (a.Primary_Contact__c == ' ')){
                system.debug('else in pryconOnAccount');
                system.debug('contactList.size()= in above for loop='+contactList.size());
                for(contact c:contactList){
                      c.Primary_Contact__c=false;
                      allrelatedcontacts.add(c);   
                }   
            }   
            update allrelatedcontacts;
            system.debug('allrelatedcontacts afet update=='+ allrelatedcontacts);
        }   
    }   
}