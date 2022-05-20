/**************************************************************************************************
*** Class Name             : FamilyTrigger
*** Class Description      : This Trigger is used to invoke FamilyTriggerHandler.
*** Author                 : Krishna
*** Class Created Date     : 08-Nov-2021
**************************************************************************************************/


trigger FamilyTrigger on Family__c (after insert,after update) {
    if(trigger.isinsert){
         FamilyTriggerHandler.addParentConToAcc(Trigger.newMap);
    }
    else if(trigger.isupdate){
        FamilyTriggerHandler.updateAcc(Trigger.newMap, Trigger.oldMap);
    }

}