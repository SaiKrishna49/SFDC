@istest
public class EventDeleteBatchClassTest {
    
	@istest
    public static void eventDeleteTestMethod(){
        date Startd=date.Today().addDays(-100);
    date endd=date.Today().addDays(-65);  
        Event__c evant = new Event__c();
        evant.Name__c = 'Test event';
evant.Start_Date_Time__c=datetime.newInstance(Startd.year(), Startd.month(),Startd.day());
evant.End_Date_Time__c=datetime.newInstance(endd.year(), endd.month(),endd.day());
        evant.Max_Seats__c = 500;
        Insert evant;
        Test.startTest();
        
        EventDeleteBatchSchedule.execute(NULL);
    /*  ContactBdayEmailBatchClass BatchClass = new ContactBdayEmailBatchClass();
        DataBase.executeBatch(BatchClass);*/
     Test.stopTest();
    }
}