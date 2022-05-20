public class CreateParentCaseHandler {
        public static void CreateParentCase(list<Case> newCseList){
        Set<Id> setOfOppId = new Set<Id>();
            system.debug('setOfOppId='+ setOfOppId);
        Set<Id> setOfCseId = new Set<Id>();
            system.debug('setOfCseId='+setOfCseId);
        List<Case> cseList = new List<Case>();
            system.debug('cseList='+cseList);
        list<opportunity> opp = new list<opportunity>();
            system.debug('opp='+opp);
        for(case cse :newCseList){
            system.debug('cse='+cse);
        for(opportunity o: opp){
            system.debug('o='+o);
        if(o.Number_of_Devices__c != o.Quotes_count__c){
            system.debug('o.Number_of_Devices__c ='+o.Number_of_Devices__c );
            system.debug('o.Quotes_count__c='+o.Quotes_count__c);
            setOfCseId.add(cse.Id);
           setOfOppId.add(cse.Opportunity__c);
        }
    }
    }
    
    List<Quote> quoteList = [Select id,OpportunityId from Quote where OpportunityId =: setOfOppId];
            system.debug('quoteList='+quoteList);
    Set<Id> duplicateId = new Set<id>();
            system.debug('duplicateId='+duplicateId);
     if(setOfCseId != null){
          for(Case cse : [SELECT ID,Opportunity__c,Quote__c,ParentId FROM Case WHERE ID IN : setOfCseId]){
              system.debug('cse='+cse);
           for(Quote qote : quoteList){
               system.debug('qote='+qote);
                if(cse.Quote__c == null && !duplicateId.contains(qote.id)){
               cse.Quote__c = qote.id;
               duplicateId.add(qote.id);
               cseList.add(cse);
                          }
                }
                     }
                   }
      if(cseList.size() > 0){
       update cseList;
       }
    }
}

        
/*if(setOfOppId.size() > 0){
            
        System.debug('Id'+ recordTypeId);
       
        Opportunity     op =  [Select id ,name,Number_of_Devices__c, recordtypeId from Opportunity where Id =: setOfOppId];
           
          Quote  quoteabc = [Select id from Quote where OpportunityId=: op.id LIMIT 1];              
             
              noOfdev = (INTEGER)op.Number_of_Devices__c;
              opprecordtypeid = op.RecordTypeId;
              quoteid = quoteabc.id;
              System.debug('Quoteid'+quoteid);
    		   
    
        }
          
    /*    if(noOfdev > 0 && recordTypeId == opprecordtypeid){
         for(Case cs: newCseList )
         {
           /* for(Integer i =1 ; i <= noOfdev ;i++){
                 Case  c = new Case();
                 c.Subject = 'Parent Case';
                 c.ParentId = cs.id;
                 c.Quote__c = quoteid; 
          c.Opportunity__c = cs.Opportunity__c;
                 caseinsert.add(c);   
           //  } */