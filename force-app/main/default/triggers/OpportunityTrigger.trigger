/**************************************************************************************************
*** trigger Name             : OpportunityTrigger
*** trigger Description      : This Trigger invokes OpportunityTriggerDispatcher to run OpportunityTriggerHandler class.
*** Author                   : Krishna
*** trigger Created Date     : 24-Nov-2021.
****************************************************************/
trigger OpportunityTrigger on Opportunity (before insert,after insert,before update,after update,before delete,after delete, after undelete) {
   OpportunityTriggerDispatcher.run(new OpportunityTriggerHandler(), 'OpportunityTrigger');
}