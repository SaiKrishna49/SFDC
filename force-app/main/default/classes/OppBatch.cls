global class OppBatch implements Database.Batchable<sobject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        string query='select id,stagename,closedate from opportunity where Stagename ="prospecting" AND CreatedDate >= LAST_N_DAYS:20 ';
        return Database.getQueryLocator(query);
    }
    global void execute(database.BatchableContext bc,list<opportunity> scope){
      system.debug('Scope===='+ scope);
         AsyncApexJob jb=[SELECT id,jobtype,totaljobitems,jobitemsprocessed,numberofErrors from AsyncApexJob where id =:bc.getJobId()];
        for(opportunity OP : (list<opportunity>)scope) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {OP.Owner.Email});
            email.setTargetObjectId(OP.OwnerId);
            email.setWhatId(OP.Id);
            string body='Dear User,<br/> Batch operation with jobId:<b>'+jb.Id;
            body=body+'<br/> processed succesfully <br/> Total jobItems:<b> '+jb.TotalJobItems;
            body=body+'<br/> No of errors :<b>'+jb.NumberOfErrors+'</b>';
            email.setSubject('Batch Status');
            email.setHtmlBody(body);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
       
    }
    global void finish(Database.Batchablecontext bc){
       /* AsyncApexJob jb=[SELECT id,jobtype,totaljobitems,jobitemsprocessed,numberofErrors from AsyncApexJob where id =:bc.getJobId()];
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        
for(opportunity OP : (list<opportunity>)scope){
String[] toadd=new String[]{OP.Owner.Email};
msg.setToAddresses(toadd);
        string body='Dear User,<br/> Batch operation with jobId:<b>'+jb.Id;
        body=body+'<br/> processed succesfully <br/> Total jobItems:<b> '+jb.TotalJobItems;
        body=body+'<br/> No of errors :<b>'+jb.NumberOfErrors+'</b>';
        msg.setSubject('Batch Status');
        msg.setHtmlBody(body);
        Messaging.Email[] emails = new Messaging.Email[]{msg};
        Messaging.sendEmail(emails);*/

  }
        
}