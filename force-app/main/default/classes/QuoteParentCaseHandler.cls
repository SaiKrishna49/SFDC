public class QuoteParentCaseHandler {
    Public static void ParentCaseQuote(list<case> Cselist){
        set<Id> OppId = new set<Id>();
        set<Id> caseId = new set<Id>();
        for(case cse : Cselist){
            if(cse.ParentId != null){
                OppId.add(cse.id);
                caseId.add(cse.id);
            }
        }
       list<Quote> Quotelist = [SELECT Id,opportunityid FROM Quote WHERE opportunityid=:OppId] ;
        for(Case cse : [SELECT ID,Opportunity__c,Quote__c,ParentId FROM Case WHERE ID IN : caseId]){
            For(Quote Q :Quotelist ){
                cse.Quote__c = Q.id;
            }
        }
        
    }
    

}