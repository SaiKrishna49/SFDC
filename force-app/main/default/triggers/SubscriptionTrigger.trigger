trigger SubscriptionTrigger on Subscription__c (after insert, after update, after delete, after undelete) {
    if(trigger.isDelete){
         SubscriptionTriggerHandler.AfterDelete(Trigger.old);
    }
    if(trigger.isupdate){
        SubscriptionTriggerHandler.AfterUpdate(Trigger.new, trigger.newmap);
    }
    if(trigger.isinsert || trigger.isUndelete){
         SubscriptionTriggerHandler.AfterInsertAndUndelete(Trigger.new);
    }
   

}