trigger TaskCreation on Opportunity (after insert) {
    List<task> TaskList =New List<task>();
    
    for(opportunity opp:trigger.new){
        
        system.debug('opp name=='+ opp.Name );
        task NewTask=new task();
        NewTask.whatid  = opp.id;
        NewTask.OwnerId = opp.OwnerId;
        NewTask.Status  = 'Not Started';
        NewTask.Subject = 'Created from TaskCration trigger automatically';
        NewTask.Description = 'Task Created from opportunity with Opportunity ID='+ opp.id;
        TaskList.add(NewTask); 
        system.debug('task id=='+ opp.id);
        
        insert TaskList;
    }
}