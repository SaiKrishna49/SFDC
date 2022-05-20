public class AtachmentHandler {
    public static void attachmentAdded(Set<Id> caseIds) {
       Set<Id> AttachmentIds = new Set<Id>();
        list<attachment> attlist = new list<attachment>();
        List<Case> updateCases = new List<Case>();
        List<Case> caseList = [SELECT Id, In_Progress__c, (SELECT ID FROM attachments) FROM Case WHERE Id IN: caseIds];
        system.debug('caseList='+ caseList);
        for(Attachment att : attlist) {
        //Check if added attachment is related to Case or not
        if(String.valueOf(att.ParentID).startsWith('500')) {
            caseIds.add(String.valueOf(att.ParentID));
            system.debug('caseids size'+ caseIds.size());
        }
    }
        for(Case myCase : caseList) {
            if(!myCase.In_Progress__c) {
                myCase.In_Progress__c = true;
                system.debug('check box'+ myCase.In_Progress__c);
                updateCases.add(myCase);
            }
        }
        if(!updateCases.isEmpty()) {
            system.debug('update cases'+!updateCases.isEmpty());
            update caseList;
            system.debug('caselist size='+ caseList.size());
        }
    }
    
}
    
    
    
    
    
    
    /* Public static void Attachment(list<case> NewCaseList){
        set<id> ParentId = new set<id>();
        List<case> CaseList = new List<case>();
        for(case cse : NewCaseList ){
            ParentId.add(cse.id);
        }
        CaseList = [SELECT ID,Description,Type,In_Progress__c FROM case WHERE ID IN: ParentId ];
        FOR(case c: CaseList){
            c.In_Progress__c = TRUE;
        }
        update caseList;
    }
	*/