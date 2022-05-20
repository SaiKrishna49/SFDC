public class EventAttendeeTriggerHandler {
    public static void SendEmail(Map<Id,Event_Attendee__c> newEventAttendeeMap){ 
        Set<Id> eventIdSet=new Set<Id>(); 
        Map<Id,Event__c> eventIdToLocation=new Map<Id,Event__c>(); 
        list<messaging.Email> messageEmailList = new list<messaging.Email>();
        for(Event_Attendee__c eventAttendeeRec : newEventAttendeeMap.values()){ 
            eventIdSet.add(eventAttendeeRec.Event__c); 
        } 
        for(Event__c eventRecords: [SELECT Id,Start_Date_Time__c,End_Date_Time__c,
                                    Location__r.City__c,Location__r.Country__c, Location__r.Landmark__c,
                                    Location__r.Postal_Code__c, Location__r.State__c,Location__r.Street__c,
                                    Organizer__r.name FROM Event__c WHERE Id IN : eventIdSet]){
                                        eventIdToLocation.put(eventRecords.Id,eventRecords); 
                                    }
        if(eventIdToLocation.size()> 0){
            for(Event_Attendee__c EvantAttendeRec : [SELECT id,Attendees__r.Name,Attendees__r.Email__c,Attendees__r.Phone__c,Event__r.Name__c,Event__r.Start_Date_Time__c,Event__r.End_Date_Time__c FROM Event_Attendee__c WHERE Id IN:newEventAttendeeMap.keyset()]){
                messaging.SingleEmailMessage message = new messaging.SingleEmailMessage();
                list<string> tooAddressList = new List<string>{EvantAttendeRec.Attendees__r.Email__c};
                    message.setToAddresses(tooAddressList);
                message.setSubject('Pass for the'+' '+ EvantAttendeRec.Event__r.Name__c);
                string body = ' Dear'+ ' '+EvantAttendeRec.Attendees__r.Name +',<br/>';
                body= body+'Thank you for registering for'+ ' '+ EvantAttendeRec.Event__r.Name__c+' <br> which will be Organized on ' +EvantAttendeRec.Event__r.Start_Date_Time__c+'& will be held in <br>'+ eventIdToLocation.get(EvantAttendeRec.Event__c).Location__r.Street__c+',';
                body= body+ eventIdToLocation.get(EvantAttendeRec.Event__c).Location__r.Country__c +',<br>';
                body= body+ eventIdToLocation.get(EvantAttendeRec.Event__c).Location__r.Landmark__c +',<br>';
                body = body+eventIdToLocation.get(EvantAttendeRec.Event__c).Location__r.State__c +',<br>';
                body = body+eventIdToLocation.get(EvantAttendeRec.Event__c).Location__r.City__c +',<br>';
                body = body+eventIdToLocation.get(EvantAttendeRec.Event__c).Location__r.Postal_Code__c +'.<br>';
                body = body+'We are excited to have you, see you in the event.<br>';
                body = body+'Thanks,<br><br>'+eventIdToLocation.get(EvantAttendeRec.Event__c).Organizer__r.name;
                message.setHtmlBody(body);
                messageEmailList.add(message);
            }
            try{
                messaging.sendemail(messageEmailList);
            }catch(exception e){
                system.debug('error='+ e.getdmlmessage(0));       
            }
        }
    }
}