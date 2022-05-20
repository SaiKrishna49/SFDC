global class EventDeleteBatchClass IMPLEMENTS Database.Batchable <sobject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        string query ='SELECT id,Name__c,Live__c,End_Date_Time__c FROM Event__c WHERE Live__c=False AND End_Date_Time__c < LAST_N_DAYS:60';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, list<Event__c> eventList){
        EventDeleteBatchHandler.DeleteEventBatch(eventList);
    }
    global void finish(Database.BatchableContext bc){
      AsyncApexJob apxJob = [SELECT Id, Status,ExtendedStatus,NumberOfErrors,JobItemsProcessed,TotalJobItems, CreatedBy.Email
        FROM AsyncApexJob WHERE Id =:bc.getJobId()];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {apxJob.CreatedBy.Email};
            mail.setToAddresses(toAddresses);
            mail.setSubject('EventDeleteBatchClass ' + apxJob.Status);
            mail.setPlainTextBody('execution of the batch has been processed.records processed' + apxJob.TotalJobItems+'With apex job ID '+apxJob.id+
           'with '+ apxJob.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}