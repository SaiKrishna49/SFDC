@istest
public class EventAttendeeTriggerTest {
    @istest
    public static void method1(){
        event__c evant = new event__c();
        evant.Start_Date_Time__c = system.today();
        evant.Max_Seats__c = 100;
        INSERT evant;
        Attendees__c attende = new Attendees__c();
        attende.Name = 'test attende';
        attende.Phone__c = '8745961231';
        attende.Email__c = 'test@mail.com';
        INSERT attende;
        Event_Attendee__c evntattende = new Event_Attendee__c();
        evntattende.Event__c = evant.Id;
        evntattende.Attendees__c = attende.Id;
        try{
            
            INSERT evntattende;
          
        }catch(exception e){
            system.debug('error='+ e.getDmlMessage(0));
            boolean errorexception = e.getMessage().contains('')? true: false;
           // system.assertEquals(errorexception, false);
           system.assertEquals(errorexception, false, 'catch exce');   
        }
    }
}