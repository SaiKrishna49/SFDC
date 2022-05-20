public class Task1class {
    public static void createCase(list<case> newcaselist){
        list<opportunity> opplist = new list<opportunity>();
        for(opportunity opp : opplist)
         for(case cse : newcaselist ){
             if(opp.Quotes_count__c == 1){
                 cse.Quote__c = cse.Opportunity__c;
             }
            
        }
    }
}
    
    /* public static void createCase(list <Case> newCseList){
        Integer noOfdev = 0;
        Id opprecordtypeid;
        Id quoteid;
        Id recordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Analog').getRecordTypeId();
    Set<Id> setOfOppId = new Set<Id>();
        List<Case> cseList = new List<Case>();
        for(Case cse: newCseList){
            if(cse.ParentId != null){
                setOfOppId.add(cse.Opportunity__c);
                system.debug('case opp'+ cse.Opportunity__c );
            }
        }
       
         List<Quote> quoteList = [Select id,OpportunityId from Quote where OpportunityId =: setOfOppId];
		//system.debug('opp id '+ OpportunityId );
       system.debug('setof opp id'+setOfOppId );
       system.debug('Quote list'+ quoteList);
       for(case c: cselist){
              cselist[0].Quote__c = Quotelist[0].id;  
           system.debug('index 0 quote ='+ cselist[0].Quote__c);
                }
                update cselist;
       system.debug('case list '+ cselist);
       }
}*/