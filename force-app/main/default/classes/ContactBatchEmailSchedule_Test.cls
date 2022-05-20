/**************************************************************************************************
*** Class Name             : ContactBatchEmailSchedule_Test
*** Class Description      : This Test class is written for ContactBatchEmailSchedule Class.
*** Author                 : Krishna
*** Class Created Date     : 25-Oct-2021

**************************************************************************************************/


@isTest
public class ContactBatchEmailSchedule_Test {
    @isTest
    public static void contactBatchEmailTestMethod(){
        Test.StartTest();
        ContactBatchEmailSchedule Schedule = new ContactBatchEmailSchedule();
        String cron = '0 9 * * * ?';
        system.schedule('Test Check', cron, Schedule);
        Test.stopTest();  
    }
}