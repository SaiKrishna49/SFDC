global class ZendeskBatchClass IMPLEMENTS Database.Batchable<sobject>, Database.AllowsCallouts{
    global Database.QueryLocator start(Database.BatchableContext Bc){
        string query='SELECT id,name FROM Account';
        system.debug('query='+query);
        return Database.getQueryLocator(query);
       
    }
    global void execute(Database.BatchableContext Bc, list<sobject> scope){
       // for(integer i=0; i< scope.size(); i++){
            system.debug('exec');
           ZenDeskApiClass.getUserResponse('https://vinithtech.zendesk.com','/api/v2/tickets.json?include=comment_count','tirumalasettisaikrishna@gmail.com','8712331193');
       // }
    }
    global void finish(Database.BatchableContext Bc){
        
    }

}