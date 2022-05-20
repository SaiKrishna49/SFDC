/**************************************************************************************************
*** Dispatcher Name             : TriggerDispatcher
*** Dispatcher Description      : This Dispatcher is used to invoke OpportunitLineItemTrigger.
*** Author                      : Krishna
*** Dispatcher Created Date     : 15-Nov-2021.
****************************************************************/

/*
@Author : Sai Krishna
@CreatedDate : 15th Nov 2021
@Description : Trigger Dispatcher.
*/
public class TriggerDispatcher {
     
   
    public static void run(ITriggerHandler handler, string triggerName){
         
        //Check if the trigger is disabled
        if (handler.IsDisabled()){
            return;
        }
         
        //Get the trigger active information from custom settings by trigger name
        Boolean isActive = TriggerSetting__c.getValues(triggerName).isActive__c;
         
        if(isActive){
            //Check trigger context from trigger operation type
            switch on Trigger.operationType {
                 
                when BEFORE_INSERT {
                    //Invoke before insert trigger handler
                    handler.beforeInsert(trigger.new);
                }
                when AFTER_INSERT {
                    //Invoke after insert trigger handler
                    handler.afterInsert(trigger.new, trigger.newMap);
                }
                when BEFORE_UPDATE {
                    //Invoke before update trigger handler
                    handler.beforeUpdate(trigger.new, trigger.newMap, trigger.old, trigger.oldMap);
                }
                when AFTER_UPDATE {
                    //Invoke after update trigger handler
                    handler.afterUpdate(trigger.new, trigger.newMap, trigger.old, trigger.oldMap);
                }
                when BEFORE_DELETE {
                    //Invoke before delete trigger handler
                    handler.beforeDelete(trigger.old, trigger.oldMap);
                }
                when AFTER_DELETE {
                    //Invoke after delete trigger handler
                    handler.afterDelete(trigger.old, trigger.oldMap);
                }
                when AFTER_UNDELETE {
                    //Invoke after undelete trigger handler
                    handler.afterUnDelete(trigger.new, trigger.newMap);
                }
            }
        }
    }
}