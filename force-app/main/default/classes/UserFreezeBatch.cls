/**************************************************************************************************
*** Class Name             : UserFreezeBatch
*** Class Description      : This class is used to send email to users to freeze their account due to inacitivity with in 7,14,21 days.
*** Author                 : Krishna
*** Class Created Date     : 01-nov-2021

**************************************************************************************************/
public class UserFreezeBatch {
    
}
/* 
global class UserFreezeBatch IMPLEMENTS Database.Batchable <sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, Name,IsActive FROM User WHERE IsActive =TRUE' ;
		//return Database.QueryLocator(query);
		return Database.getQueryLocator(query);
        
    }
    global void execute(Database.BatchableContext bc, list<user> userList){
        list<messaging.SingleEmailMessage> mailList = new list<messaging.SingleEmailMessage>();
        for(user useRec : userList){
            
        }
    }

}*/