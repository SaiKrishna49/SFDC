public class CaseStatusSampleHandler{
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


























/*public class CaseStatusSampleHandler {
    public static void CaseStatus(Map<id,case> NewcaseMap , map<id,case> oldcaseMap){
        Id parentcaseId;
        list<case> caselist = new list<case>();
        list<casestatus> ChildCaseStatusList = new list<casestatus>();
        integer comparevalue = 4;
        string parentcasevalue = '';
        map<string, integer> Assigncomparisionvalue = new map<string,integer>{
            'New' => 1,
                'Working' => 2,
                'Escalated' => 3,
                'Closed' => 4
                };                                                                                                                                                                                                                                                                                                                                                                                                                                              
                    set<id> cids = new set<id>();
        for(case cse : NewcaseMap.values()){
            if(cse.ParentID!= null){
                cids.add(cse.ParentID);
            }
            if(cse.ParentID != null){
                caselist=[SELECT ID,ParentID,Status FROM case WHERE ParentID =:cids ];
                system.debug('caselist in sortorder='+ caselist);
                list<casestatus> ChildCaseStatusList = [SELECT ID,MasterLabel,ApiName,SortOrder FROM CaseStatus ORDER BY SortOrder ASC];
                system.debug('ChildCaseStatusList  in sortorder='+ ChildCaseStatusList);
            }
            
        }
        
        if(!caselist.isempty()){
            
            for( case caseloop :ChildCaseStatusList){
                system.debug('caseloop='+ caseloop);
                if(Assigncomparisionvalue.get(caseloop.status) <= comparevalue )  {
                    comparevalue = Assigncomparisionvalue.get(caseloop.status);
                    system.debug('=comparevalue=='+ comparevalue);
                    parentcasevalue = caseloop.status;
                    system.debug('parentcasevalue=='+ parentcasevalue);
                }
            }
        }
        
        case c = new case();
        
        c.Status = parentcasevalue;
        c.Type = 'other';
        c.Description = 'caseStatusSampleHandler Class';
        update c;
        
    }
    
}



/*
 * get all childs childs based on parent
 * loop childs in loop
 * based on corresponding record status in loop get value from map
 * assign those to list
 * after loop sort those values of status outside loop
 * get first value in list and get parent case status (query) and compare whethere equal or not
 * if not equal assign parent case to new value and assign
 * /




















/*  Set<Id> csIds = new Set<Id>();
for(case cs : clist){
csIds.add(cs.parentId);
}

list<case> cslist = new list<case>([SELECT Id, status,ParentId FROM Case Where ParentId IN : csIds ]);
if(cslist.size()>0){
list<case> Parentcslist = new list<case>([SELECT id, status FROM case WHERE Id IN : csIds]);
list<casestatus> ParentCsUpdateList = new list<casestatus> ([SELECT Id, MasterLabel, ApiName, SortOrder FROM CaseStatus]);
for(casestatus parentcase :ParentCsUpdateList ){
system.debug('Sortorder in for loop===='+ parentcase);
for(case cse : cslist){
if(cse.ParentId != null){
if(cse.ParentId == cse.id){
if(cse.status == parentcase.ApiName){
if(parentcase.size()>0){
=======
if( ISPICKVAL(cse.status, "New"), 1, 
if( ISPICKVAL(cse.status, "Working"), 2,
if( ISPICKVAL(cse.status, "Escalated"), 3,
if( ISPICKVAL(cse.status, "Closed"), 4,
5))))
======
CASE(cse.status,
"New", "1",
"Working", "2",
"Needs Analysis", "Insert 3rd Document ID",
"Value Proposition", ...
)
=================================================                                    
Schema.SObjectType s = Schema.getGlobalDescribe().get('Case') ;
Schema.DescribeSObjectResult r = s.getDescribe() ;
Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
Schema.DescribeFieldResult fieldResult = fields.get('Status').getDescribe();
List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
for( Schema.PicklistEntry pickListVal : ple){
System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
}    */