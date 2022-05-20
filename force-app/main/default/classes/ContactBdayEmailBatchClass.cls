/**************************************************************************************************
*** Class Name             : ContactBdayEmailBatchClass
*** Class Description      : This class will be invoked everyday to send birthday wishes to the employees.
*** Author                 : Krishna
*** Class Created Date     : 25-Oct-2021

**************************************************************************************************/

global class ContactBdayEmailBatchClass IMPLEMENTS Database.Batchable <sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        Date tody = system.today().addDays(-1);
        String query = 'SELECT Id, Name,Date_of_Birth__c, Email FROM Contact WHERE DAY_IN_MONTH(Date_of_Birth__c) = ' + tody.day() 
                        + ' AND CALENDAR_MONTH(Date_of_Birth__c) = ' + tody.month() ;
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Contact> conList) {
        List<Messaging.SingleEmailMessage> mailsList = new List<Messaging.SingleEmailMessage>();
        for(Contact conRec : conList) {
            List<String> toAddresses = new List<String>{conRec.Email};
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            mail.setSubject('Belated Happy Birthday');
            String messageBody = '<html><body>Hi ' + conRec.Name + ',<br/>Many More Happy Returns of the day. <br/>'+
                                '<br/><b>Regards,</b><br/>Hr</body></html>';
            mail.setHtmlBody(messageBody);
            mailsList.add(mail);
        }
        Messaging.sendEmail(mailsList);
        
    }
    global void finish(Database.BatchableContext bc){
        
    }
}