public class Count_Eg1 
/*{
    
    public static void countcontacts(List<contact> newcontact,List<contact> oldcontact){
     
        set<id> accids= new set<id>();
               
        if(newcontact !=null){
            for(Contact c:newcontact){
                if(c.AccountId!=null){
                accids.add(c.accountid);
                }
            }      
       }if(oldcontact!=null){
            for(Contact c:oldcontact){
                accids.add(c.accountid);
            }
       }
     List<Account> acc = [Select id, Contacts_Counter__c,(Select id from Contacts) from Account where id IN: accids];
        if(acc!=null){
        for(Account accValue:acc){
            accValue.Contacts_Counter__c = accValue.Contacts.size();
        } 
        }
        if(!acc.isempty()){
        update acc;
        }
        
        
    } 
    
}*/

{
    Public static void countCon(List<contact> con)
    {
        Set<id> setAccId = new set<id>();
        if(trigger.isInsert || trigger.isUndelete)
        {
            for(contact C : con)
            {
                system.debug('trigger.isInsert || trigger.isUndelete');
               setAccId.add(C.AccountId) ;
                system.debug('setAccId=='+ setAccId);
            }
        }
        if(trigger.isdelete || trigger.isupdate)
        {
            for(contact c: con)
            {
                system.debug('trigger.isdelete');
                setAccId.add(C.AccountId);
                system.debug('setAccId=='+ setAccId);
            }
        }
        if(trigger.isupdate)
        {
            for(contact c : con)
            {
                system.debug('trigger.isupdate');
               setAccId.add(C.AccountId); 
                system.debug('setAccId=='+ setAccId);
            }
        }
        list<Account> AccsList = [SELECT id,Contacts_Counter__c, (Select id from contacts) FROM Account WHERE ID =:setAccId ];
        For(Account Acc : AccsList)
        {
            Acc.Contacts_Counter__c = Acc.contacts.size();
            System.debug('Account List Size=='+Acc.contacts.size());
        }
       update AccsList;
    }

}