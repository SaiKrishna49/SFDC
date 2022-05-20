/**************************************************************************************************
*** Trigger Name             : OpportunityLineItemTrigger
*** Trigger Description      : This Trigger is used to invoke OpportunityLineItemTriggerHandler class.
*** Author                   : Krishna
*** Trigger Created Date     : 15-Nov-2021.
****************************************************************/

trigger OpportunitLineItemTrigger on OpportunityLineItem (before insert, after insert, before update, after update, before delete, after delete, after unDelete) {
  TriggerDispatcher.run(new OpportunityLineItemTriggerHandler(), 'OpportunitLineItemTrigger');
  // OpportunitylineitemHandlerclass.afterInsert(Trigger.new, Trigger.newMap);
}