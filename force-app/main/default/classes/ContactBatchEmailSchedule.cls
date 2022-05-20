/**************************************************************************************************
*** Class Name             : ContactBatchEmailSchedule
*** Class Description      : This class will invoke 'ContactBdayEmailBatchClass' everyday to schedule batch class to send birthday wishes to the employees.
*** Author                 : Krishna
*** Class Created Date     : 25-Oct-2021

**************************************************************************************************/

public class ContactBatchEmailSchedule implements Schedulable {
    public void execute (SchedulableContext sc){
        ContactBdayEmailBatchClass conBatchClass = new ContactBdayEmailBatchClass();
        Database.executeBatch(conBatchClass);
    }
}