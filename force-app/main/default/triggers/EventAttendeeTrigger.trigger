trigger EventAttendeeTrigger on Event_Attendee__c (after insert) {
EventAttendeeTriggerHandler.SendEmail(Trigger.newmap);
}