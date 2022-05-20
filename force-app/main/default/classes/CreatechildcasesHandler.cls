public class CreatechildcasesHandler {
    public static void createCase( list<case> newCseList){
        Set<Id> setOfOppId = new Set<Id>();
        Set<Id> setOfCseId = new Set<Id>();
        Set<Id> SetOfQuoteId = new Set<id>();
        List<Case> cseList = new List<Case>();
        for(Case cse: newCseList){
            system.debug('case for loop in method='+ cse);
            setOfCseId.add(cse.Id);	
            setOfOppId.add(cse.Opportunity__c);
            system.debug('setOfCseId ='+ setOfCseId);
            system.debug('setOfOppId='+ setOfOppId);	
        }
        List<Quote> quoteList = [Select id,OpportunityId from Quote where OpportunityId =: setOfOppId];
        system.debug('quoteList='+ quoteList);
        
        if(setOfCseId != null){
            system.debug('setOfCseId after QuoteList ='+ setOfCseId);
            Id Digital_RECORDTYPEID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Digital').getRecordTypeId();
            Id Analog_RECORDTYPEID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Analog').getRecordTypeId();
            for(Case cse : [SELECT ID,Opportunity__c,Opportunity__r.RecordTypeId ,Opportunity__r.Number_of_Devices__c,Quote__c,
                            ParentId FROM Case WHERE ID IN : setOfCseId])
            {
                system.debug('For loop case ='+ cse);
                for(Quote qote : quoteList){
                    system.debug('For loop Quote='+ qote);
                    
                    
                    if(cse.Opportunity__r.Number_of_Devices__c == 1 ){
                        system.debug('--coming if----');
                        system.debug('Number of dev='+ cse.Opportunity__r.Number_of_Devices__c );
                        system.debug('-------qote----------'+  qote);
                        cse.Quote__c = qote.id;
                        system.debug(' cse.Quote__c. ='+  cse.Quote__c);
                        system.debug('qote.id='+ qote.id);
                        cse.description = qote.id;
                        cse.Type = 'Electrical';
                        cse.Origin = 'Phone';
                        cselist.add(cse);
                        system.debug('case list ='+ cselist );
                    } 
                    else if(cse.Quote__c == null  && !SetOfQuoteId.contains(qote.id) && cse.ParentId != null && cse.Opportunity__r.RecordTypeId == Analog_RECORDTYPEID){
                        system.debug('Quote in case ='+cse.Quote__c );
                        system.debug('SetOfQuoteId ='+ SetOfQuoteId );
                        system.debug('SetOfQuoteId contains Quote id = '+ (!SetOfQuoteId.contains(qote.id)));
                        cse.Quote__c = qote.id;
                        cse.Origin = 'Web';
                        SetOfQuoteId.add(qote.id);
                        cseList.add(cse);   
                    }
                    else if(cse.Quote__c == null  && !SetOfQuoteId.contains(qote.id) && cse.Opportunity__r.Number_of_Devices__c > 1 && cse.Opportunity__r.RecordTypeId == Digital_RECORDTYPEID){
                        system.debug('Quote in case ='+cse.Quote__c );
                        system.debug('SetOfQuoteId ='+ SetOfQuoteId );
                        system.debug('SetOfQuoteId contains Quote id = '+ (!SetOfQuoteId.contains(qote.id)));
                        cse.Quote__c = qote.id;
                        cse.Origin = 'Email';
                        SetOfQuoteId.add(qote.id);
                        cseList.add(cse);   
                    }
                }
            }
        }
        if(cseList.size() > 0){   
            futurecasemethod(json.serialize(cseList));
            system.debug('cseList.size() ='+ cseList.size() );
        }
    }
    @future
    public static void futurecasemethod(String caseString){
        List<case> cseList = (List<case>)Json.deserialize(caseString,List<case>.class);
        update cseList;
        system.debug('case list query ='+ cseList);
    } 
    
    public static void updateChildCaseStatus(list<Case> newCseList, Map<Id,Case> oldCaseMap){
        Set<Id> setOfParentCseId = new Set<Id>();
        for(Case cse: newCseList){
            system.debug(cse.ParentId);
            if(cse.ParentId != null && cse.Status != oldCaseMap.get(cse.Id).Status)
                setOfParentCseId.add(cse.ParentId);
        }
        Map<Integer,string> leastStatusOrderMap = new Map<Integer,String>();
        Map<string, integer> rankingStatusValueMap = new Map<string,integer>{
            'New' => 1,
                'Working' => 2,
                'Escalated'=> 3,
                'Closed' => 4
                
                };
                    
                    List<case> childCaseList = new List<case>();    
        if(setOfParentCseId.size() > 0)
            childCaseList = [SELECT ID,ParentID,Status FROM Case WHERE ParentID =:setOfParentCseId AND Status != null];
        List<Integer> leastOrder = new List<Integer>();
        List<Case> updateParentCase = new List<Case>();
        if(setOfParentCseId.size() > 0){
            for(Case parentCase : [SELECT ID,Status FROM Case WHERE ID =: setOfParentCseId]){
                if(childCaseList.size() > 0){
                    for(Case childCase : childCaseList){
                        if(rankingStatusValueMap.get(childCase.status) <= 4){
                            leastOrder.add(Integer.valueOf(rankingStatusValueMap.get(childCase.status)));
                            System.debug('leastatusorder'+leastOrder);
                            if(!leastStatusOrderMap.containsKey(rankingStatusValueMap.get(childCase.status))){
                                leastStatusOrderMap.put(rankingStatusValueMap.get(childCase.status),childCase.status);
                                System.debug('leastatusordermap'+leastStatusOrderMap);
                            }
                        }           
                    }
                }
                leastOrder.sort();
                System.debug('leastValue'+leastOrder);
                parentCase.Status = leastStatusOrderMap.get(leastOrder.get(0));
                updateParentCase.add(parentCase);
                System.debug('Updated Pareant case value'+  updateParentCase);
            }
        }
        
        if(updateParentCase.size() > 0)
            update updateParentCase;
        
    }
}



















/*

public class CreatechildcasesHandler {
    public static void createCase(list<Case> newCseList){
        Set<Id> setOfOppId = new Set<Id>();
        Set<Id> setOfCseId = new Set<Id>();
        Set<Id> setOfParentCseId = new Set<Id>();
        List<Case> cseList = new List<Case>();
        List<Opportunity> opp = new List<Opportunity>();
        for(Case cse: newCseList){
            setOfCseId.add(cse.Id);
            setOfOppId.add(cse.Opportunity__c);     
        }
        List<Quote> quoteList = [Select id,OpportunityId from Quote where OpportunityId =: setOfOppId];
        Set<Id> duplicateId = new Set<id>();
        Id Digital_RECORDTYPEID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Digital').getRecordTypeId();
        if(setOfCseId != null){
            for(Case cse : [SELECT ID,Opportunity__c,Opportunity__r.RecordTypeId ,Opportunity__r.Number_of_Devices__c,Quote__c,ParentId FROM Case WHERE ID IN : setOfCseId]){
                for(Quote qote : quoteList){
                    system.debug('==1='+cse.Opportunity__r.Number_of_Devices__c);
                    if(cse.Opportunity__r.Number_of_Devices__c ==1 || cse.Opportunity__r.RecordTypeId == Digital_RECORDTYPEID){
                        cse.Quote__c = qote.id;
                        cseList.add(cse);
                    }
                    
                    
                    
                    else if(cse.Quote__c == null && !duplicateId.contains(qote.id) && cse.ParentId != null){
                        cse.Quote__c = qote.id;
                        duplicateId.add(qote.id);
                        cseList.add(cse);
                    }
                }
            }
        }
        
        if(cseList.size() > 0)
        {
            update cseList;
        }
        
        
    }
    
}






*/









/*

public class CreatechildcasesHandler { 
public static void createCase(list<Case> newCseList){ 
Set<Id> setOfOppId = new Set<Id>(); 
Set<Id> setOfCseId = new Set<Id>(); 
Set<Id> duplicateId = new Set<id>(); 
List<Case> cseList = new List<Case>(); 

for(Case cse: newCseList){ 

setOfCseId.add(cse.Id); 
setOfOppId.add(cse.Opportunity__c); 
}

List<Quote> quoteList = [Select id,OpportunityId from Quote where OpportunityId =: setOfOppId]; 


for(Case cse : [SELECT ID,Opportunity__c,Opportunity__r.Number_of_Devices__c,Quote__c,ParentId FROM Case WHERE ID IN : setOfCseId]){ 
for(Quote qote : quoteList){ 
system.debug('Number_of_Devices__c==1='+cse.Opportunity__r.Number_of_Devices__c); 
if(cse.Opportunity__r.Number_of_Devices__c == 1){ 
system.debug('Quote id field'+ qote.id);
cse.Quote__c = qote.id; 
system.debug('Quote field is case'+ cse.Quote__c);
cseList.add(cse); 
} 
else if(cse.Quote__c == null && !duplicateId.contains(qote.id) && cse.ParentId != null)
{
system.debug('If Else loop');
cse.Quote__c = qote.id; 
duplicateId.add(qote.id); 
cseList.add(cse); 
} 
} 
}
if(cseList.size() > 0) { 
update cseList; 
system.debug('Size of cselist = '+ cseList);
system.debug('Size of caselist count'+ cselist.size());
}
} 

}
*/