trigger ZenDeskApiClassTrigger on Integration__c (after insert) {
    String jsonString = json.serialize(Trigger.NEW);
    system.debug('Trigger.NEW  =='+Trigger.NEW);
    system.debug('jsonString=='+jsonString);
ZenDeskApiClass.getUserResponse(jsonString);
}