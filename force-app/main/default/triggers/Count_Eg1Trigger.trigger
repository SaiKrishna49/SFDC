trigger Count_Eg1Trigger on Contact (after insert, after update, after delete, after undelete)
/*{
    if(Trigger.isinsert || Trigger.isupdate || trigger.isdelete || Trigger.isundelete){
       
        Count_Eg1.Countcontacts(trigger.new,trigger.old);
        
    }
}

if(Trigger.isAfter)
{
    Map<Id,List<Contact>> MapOfActIdandConList = new Map<Id,List<Contact>>();
    List<Account> lstAct = new List<Account>();
    Set<Id> AccountIdSetNew = new Set<Id>();
    Set<Id> AccountIdSetOld = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate)
    {
        for(Contact contNew : Trigger.New)
        {
            if(contNew.AccountId != null)
            {
                AccountIdSetNew.add(contNew.AccountId);
            }
        }
        if(AccountIdSetNew.size()>0){
            List<Contact> lstContNew = [Select Id,AccountId from Contact where AccountId in: AccountIdSetNew ];
            for(Contact ct : lstContNew)
            {
                if(MapOfActIdandConList.containsKey(ct.AccountId))
                {
                    MapOfActIdandConList.get(ct.AccountId).add(ct);
                }
                else
                {
                    MapOfActIdandConList.put(ct.AccountId, new List<Contact> {ct});
                }
            }
            
        }
    }
    
    if(Trigger.isDelete || Trigger.IsUpdate)
    {
        for(Contact contOld : Trigger.Old)
        {
            if(contOld.AccountId != null)
            {
                AccountIdSetOld.add(contOld.AccountId);
            }
        }
        if(AccountIdSetOld.size()>0){
            List<Contact> lstContOld = [Select Id,AccountId from Contact where AccountId in: AccountIdSetOld ];
            for(Contact ct : lstContOld)
            {
                if(MapOfActIdandConList.containsKey(ct.AccountId))
                {
                    MapOfActIdandConList.get(ct.AccountId).add(ct);
                }
                else
                {
                    MapOfActIdandConList.put(ct.AccountId, new List<Contact> {ct});
                }
            }
        }
    }
    
    for( Id actId : MapOfActIdandConList.keySet())
    {
        Account act = new Account();
        act.Id = actId;
        act.Contacts_Counter__c = MapOfActIdandConList.get(actId).size();
        lstAct.add(act);
    }
    if(lstAct.size()>0)
    {
        update lstAct;
    }
    
}

*/

{   
    if(Trigger.isinsert || Trigger.isupdate || Trigger.isundelete)
    {
        Count_Eg1.countCon(Trigger.new);
    }
    if(Trigger.isDelete)
    {
         Count_Eg1.countCon(Trigger.old); 
    }
}