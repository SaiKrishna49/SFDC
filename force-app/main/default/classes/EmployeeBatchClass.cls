/**************************************************************************************************
*** Class Name             : EmployeeBatchClass
*** Class Description      : This class will be invoked everyday to send birthday wishes to the employees.
*** Author                 : Krishna
*** Class Created Date     : 25-Oct-2021

**************************************************************************************************/


global class EmployeeBatchClass IMPLEMENTS Database.Batchable <sObject>
{
    global Database.queryLocator start(Database.BatchableContext bc) {
        Date tody = system.today();
        String SOQL = 'SELECT Id, Name,DOB__c, Email__c FROM Employee__c WHERE DAY_IN_MONTH(DOB__c) = ' + 
            tody.day() +  ' AND CALENDAR_MONTH(DOB__c) = ' + tody.month();
        return Database.getQueryLocator(SOQL);
    }
    global void execute(Database.BatchableContext bc, List<Employee__c> employeeList) {
        List<Messaging.SingleEmailMessage> mailsList = new List<Messaging.SingleEmailMessage>();
        for(Employee__c m : employeeList) {
            List<String> toAddresses = new List<String>{m.Email__c};           
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            mail.setSubject('Happy Birthday Wishes');
            String messageBody = '<html><body>Hi ' + m.Name + 
									',<br/>Many More Happy Returns of the day.<br/ '+
									'<br/><br/><b>Regards,</b><br/>Hr</body></html>';
                                        
            mail.setHtmlBody(messageBody); 
            mailsList.add(mail);          
        } 
        Messaging.sendEmail(mailsList);  
    }
    global void finish(Database.BatchableContext bc) {
        
    }
}