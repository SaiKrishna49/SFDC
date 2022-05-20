public class EventSpeakerTriggerHandler {
    public static void rejectDuplicate(list<EventSpeakers__c> newEventSpeakersList){
        set<id> EventIdSet = new set<id>();
        set<id> SpeakerIdSet = new set<id>();
        map<id,EventSpeakers__c> EventSpeakerMap = new map<id,EventSpeakers__c>();
        for(EventSpeakers__c EveSpekr : newEventSpeakersList){
            EventIdSet.add(EveSpekr.Event__c);
            SpeakerIdSet.add(EveSpekr.Speaker__c);
        }
        if(EventIdSet.size() > 0){
            for(EventSpeakers__c  EveSpekrRec : [SELECT id,Name,Speaker__c,Event__c FROM EventSpeakers__c WHERE Event__c IN : EventIdSet AND Speaker__c IN : SpeakerIdSet]){
                EventSpeakerMap.put(EveSpekrRec.Speaker__c, EveSpekrRec);
            }
            if(EventSpeakerMap.size() >0){
                for(EventSpeakers__c EventSpeakerRecord : newEventSpeakersList){
                    if(EventSpeakerMap.get(EventSpeakerRecord.Speaker__c).Event__c == EventSpeakerRecord.Event__c ){
                        EventSpeakerRecord.addError('For a Speaker there will be only one event at a time');
                    }
                }
            }
        }
    }
}