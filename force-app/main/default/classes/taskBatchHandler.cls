global class taskBatchHandler implements Database.Batchable<Sobject> {
    global database.QueryLocator start(database.BatchableContext bc){
        String conditon = Label.getWeekdata;
        string query='select id,status,AccountId from Task where CreatedDate=' + conditon ;
        System.debug('Query:'+query);
        return database.getQueryLocator(query);
    }
    
    global void execute(database.BatchableContext bc, List<Task>taskList){
        list<Account>accountList=new list<Account>();
        set<id>taskIds=new set<id>();
        
        System.debug('Tasks are:'+taskList);
        
        for(Task tasks:taskList){
            if(tasks.Status=='Completed'){
                taskIds.add(tasks.AccountId);
            }
        }
        
        System.debug('Tasks Ids are:'+taskIds);
        
        List<Account>accList=[select id,Name,Last_Activity_Date__c,(select Id,Status,CreatedDate,CompletedDateTime from Tasks order by CreatedDate desc limit 1)
                              from Account where Id IN:taskIds];
        DateTime dt;
        
        System.debug('TaskList:'+accList);
        
        for(Account acc:accList){
            for(Task t:acc.tasks){
                dt=t.CompletedDateTime;
                t.WhatId=acc.Id;
            }
            acc.Last_Activity_Date__c=dt;
            system.debug('acc.Last_Activity_Date__c=='+ acc.Last_Activity_Date__c);
            system.debug('dt=='+dt);
            system.debug('acc id=='+acc.id);
            system.debug('acc id=='+ acc.Name);
            accountList.add(acc);
            
        }
        System.debug(' Before AccList:'+accountList);
        update accountList;
        System.debug('After AccList:'+accountList);
    }
    global void finish(database.BatchableContext bc){
        AsyncApexJob a=[SELECT id,status,NumberOfErrors,JobItemsProcessed,TotalJobItems,CreatedBy.Email
                        FROM AsyncApexJob WHERE id=:Bc.getJobId()];
        
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        String[] toAddress=new String[]{a.CreatedBy.Email};
            mail.setToAddresses(toAddress);
        mail.setSubject('Apex Job Status:'+a.Status);
        System.debug('Errors:'+a.NumberOfErrors);
        mail.setPlainTextBody('The batch apex jobs processed'+a.TotalJobItems + 'batches with'+a.NumberOfErrors + 'failures.');
        messaging.Email[] messages=new messaging.Email[]{mail};
            messaging.sendEmail(messages);
        
        
    }
}


























/*global class taskBatchHandler IMPLEMENTS Database.Batchable<sobject>
{
    global database.QueryLocator start(Database.BatchableContext bc){
        String conditon = Label.getWeekdata;
        String query = 'SELECT Id,createddate FROM Task where isclosed= true AND CreatedDate ='+ conditon; 
        return Database.getQueryLocator(query);
    }
    global void execute (database.BatchableContext bc, list<Task> taskList)
    {
        list<Account>accountList=new list<Account>();
        set<id> taskIdSet = new set<id>();
        for(Task tsk : taskList){
            taskIdSet.add(tsk.accountId);
        }
        List<Account> accList = [SELECT id,(SELECT Id,createddate,CompletedDateTime FROM Tasks ORDER BY CompletedDateTime DESC LIMIT 1) FROM account WHERE ID IN :taskIdSet];
            //accRec.Last_Activity_Date__c = accRec.tasks.completedDate;
            DateTime dt;
            for(Account acc:accList){
                       for(Task t:accList.tasks){
                       dt=t.CompletedDateTime;
                        t.WhatId=acc.Id;
                       }
                acc.Last_Activity_Date__c=dt;
              accountList.add(acc);
       
            }
        }
    
    global void finish(database.BatchableContext bc){
        AsyncApexJob a=[SELECT id,status,NumberOfErrors,JobItemsProcessed,TotalJobItems,CreatedBy.Email
FROM AsyncApexJob WHERE id=:Bc.getJobId()];

Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
String[] toAddress=new String[]{a.CreatedBy.Email};
mail.setToAddresses(toAddress);
mail.setSubject('Apex Job Status:'+a.Status);
System.debug('Errors:'+a.NumberOfErrors);
mail.setPlainTextBody('The batch apex jobs processed'+a.TotalJobItems + 'batches with'+a.NumberOfErrors + 'failures.');
messaging.Email[] messages=new messaging.Email[]{mail};
messaging.sendEmail(messages);

    }
}
*/