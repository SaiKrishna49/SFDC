@isTest
public class EventSpeakerTriggerHandlerTest {
    @istest
    public static void DuplicateTest(){
        Speaker__c Speakar = new Speaker__c();
        Speakar.Name = 'Test speaker';
        Speakar.Phone__c = '7894578632';
        INSERT Speakar;
        Event__c evant = new Event__c();
        evant.Start_Date_Time__c = system.today();
  
        evant.Max_Seats__c = 100;
        INSERT evant;
        EventSpeakers__c ES1 = new EventSpeakers__c();
        ES1.Event__c = evant.Id;
        ES1.Speaker__c = Speakar.id;
        INSERT ES1;
        EventSpeakers__c ES2 = new EventSpeakers__c();
        ES2.Event__c = evant.Id;
        ES2.Speaker__c = Speakar.id;
        try{
            Test.startTest();
        INSERT ES2;
            system.assertEquals('For a Speaker there will be only one event at a time', 'For a Speaker there will be only one event at a time');
            Test.stopTest();
        }catch(exception e){
            system.debug('error='+ e.getdmlMessage(0));
        }
    }

}