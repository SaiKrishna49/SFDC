public class MapQuoteHandler {
    public static void MapQuote(list<case> newCseList, map<id,case> oldmap){
     set<id> SetOfOppId = new set<id>();
        set<id> SetOfCaseId = new set<id>();
        list<case> caselist = new list<case>();
        for(case cse : newCseList ){
            if(cse.Quote__c == null){
                SetOfCaseId.add(cse.id);
                SetOfOppId.add(cse.Opportunity__c);
                
            }
            list<Quote> Quotelist = [SELECT id,opportunityId FROM Quote WHERE opportunityId=:SetOfOppId ];
            set<id> DupId = new set<id> ();
           if(Quotelist.size() >= 2){
                for(Case cs :[SELECT ID,Opportunity__c,Quote__c,ParentId FROM Case WHERE ID IN : SetOfCaseId])
                {
                    for(Quote Qote : Quotelist ){
                        cs.Quote__c = Qote.id;
                        DupId.add(Qote.id);
                        caselist.add(cs);
                    }
                }
            }
        
        }
        if(caselist.size()> 0){
            update(caselist);
        
        }
        
    }
}

        
        
        
        
        
        
        
        
  /*      id oppREcordTypeId;
		id QuoteId;
		id RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Digital').getRecordTypeId();
        system.debug('Id RecordID DIgital :'+RecordTypeId);
        set<id>  setOfOppId = new set<id>();
        system.debug('Set of Opp Id :'+ setOfOppId );
		set<id>  setOfcaseid = new set<id>();
        system.debug('Set of case Id : '+ setOfcaseid);
        list<case> cselist = new list<case>();
        for(case cse:newCseList){
            setOfcaseid.add(cse.id);
            system.debug('Set of case Id in for loop : '+ setOfcaseid);
			setOfOppId.add(cse.id);
            system.debug('Set of Opp Id in for loop :'+ setOfOppId );
        }
        list<Quote> Quotelist = [SELECT ID,opportunityId FROM quote WHERE opportunityId =: setOfOppId];
        system.debug('Quote List is : '+ Quotelist );
        Set<Id> duplicateId = new Set<id>();
        system.debug('DUplicate Id values are '+ duplicateId );
        for(case cse : [SELECT ID,Opportunity__c,Quote__c FROM case WHERE ID IN : SetOfcaseid]){
            system.debug('case in for loop query'+ cse);
            for(Quote qote : Quotelist){
                system.debug('Quote if for loop:'+ qote);
                if(recordTypeId == opprecordtypeid){
                    system.debug('Record typr id :' + recordTypeId);
                    system.debug('opp rec type id :'+ opprecordtypeid);
                    cse.Quote__c = qote.id;
                    system.debug('Quote id :'+ qote.id);
                    duplicateId.add(qote.id);
                    cselist.add(cse);
                }  
            }
        }
        
        if(cselist.size() >0){
            update cselist;
            system.debug('cselist afert size :'+ cselist );
        }
		
    }

}

/*public class CreatechildcasesHandler {
  public static void createCase(list <Case> newCseList, map <Id, Case> oldCseMap){
        Integer noOfdev = 0;
        Id opprecordtypeid;
        Id quoteid;
        Id recordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Analog').getRecordTypeId();
        Set<Id> setOfOppId = new Set<Id>();
        Set<Id> setOfCseId = new Set<Id>();
        List<Case> caseinsert = new List<Case>();
        for(Case cse: newCseList){
          if( cse.Status == 'Working' && cse.In_Progress__c==false  && (oldCseMap == null ||  
                                                  cse.Status != oldCseMap.get(cse.Id).Status)){
            setOfCseId.add(cse.id);                                          
            setOfOppId.add(cse.Opportunity__c);   
                                                      
          
                                                  }
        }
         
        if(setOfOppId.size() > 0){
            
            
          System.debug('Id'+ recordTypeId);
       
              
              Opportunity     op =  [Select id ,name,Number_of_Devices__c, recordtypeId from Opportunity where Id =: setOfOppId];
           
            Quote  quoteabc = [Select id from Quote where OpportunityId=: op.id LIMIT 1];
              
             
              noOfdev = (INTEGER)op.Number_of_Devices__c;
              opprecordtypeid = op.RecordTypeId;
              quoteid = quoteabc.id;
              System.debug('Quoteid'+quoteid);
        }
          
        if(noOfdev > 0 && recordTypeId == opprecordtypeid){
         for(Case cs: newCseList )
         {
            for(Integer i =1 ; i <= noOfdev ;i++){
                 Case  c = new Case();
                 c.Subject = 'Child Case'+i;
                 c.ParentId = cs.id;
                
                 c.Quote__c= quoteid; 
                 
               
                 c.Opportunity__c = cs.Opportunity__c;
                 caseinsert.add(c);   
               
                
            } 
             cs.In_Progress__c=TRUE;
         }
        }
        if(caseinsert.size() > 0)
        insert caseinsert;
    }
}

*/