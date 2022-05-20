trigger EventSpeakerTrigger on EventSpeakers__c ( before insert , before update) {
	EventSpeakerTriggerHandler.rejectDuplicate(Trigger.new);
}