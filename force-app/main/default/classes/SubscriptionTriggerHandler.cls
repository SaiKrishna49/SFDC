public class SubscriptionTriggerHandler {
    public static void AfterInsertAndUndelete(list<Subscription__c> NewSubscriptionList){
        Set<Id> SetOfAccountIds =new Set<Id>();
        for(Subscription__c SubRec: NewSubscriptionList){
            if(SubRec.Account__c !=null){
                SetOfAccountIds.add(SubRec.Account__c);
            }
        }
        if(SetOfAccountIds.Size() > 0){
            UpdateAccounts(SetOfAccountIds);
        }
        
    }
    Public static void AfterDelete(list<Subscription__c> oldSubscriptionList){
        Set<Id> SetOfAccountIds =new Set<Id>();
        for(Subscription__c SubRec: oldSubscriptionList){
            if(SubRec.Account__c !=null){
                SetOfAccountIds.add(SubRec.Account__c);
            }
        }
        if(SetOfAccountIds.Size() > 0){
            UpdateAccounts(SetOfAccountIds);
        }
        
    }
    public static void AfterUpdate(List<Subscription__c> newSubscriptionList,Map<Id,Subscription__c> oldnewSubscriptionList){
        Set<Id> SetOfAccountIds =new Set<Id>();
        for(Subscription__c newSubData: newSubscriptionList)
        {
            Subscription__c OldSubData=oldnewSubscriptionList.get(newSubData.Id);
            
            if(OldSubData.Account__c != newSubData.Account__c)
            {
                if(newSubData.Account__c!= null){
                    SetOfAccountIds.add(newSubData.Account__c);
                }
                if(OldSubData.Account__c != null){
                    SetOfAccountIds.add(OldSubData.Account__c);
                }
                if(SetOfAccountIds.Size() > 0){
                    UpdateAccounts(SetOfAccountIds);
                }
            }
            
            
        }
    }
    
    
    private static void UpdateAccounts(set<Id> Accountids){
        List<Account> NewAccountList=[Select Id, Subscription_Total_Amount__c,(Select Id ,Account__c,Amount__c FROM Subscriptions__r) FROM Account WHERE id In:Accountids];
        for(Account EachAccount:NewAccountList){
            integer val=0;
            for(Subscription__c cont:EachAccount.Subscriptions__r)
            {
                val += (Integer)cont.Amount__c;
            }
            EachAccount.Subscription_Total_Amount__c= val;  
        }
        
        if(NewAccountList.Size() > 0){
            Update NewAccountList;
        }
    }
}