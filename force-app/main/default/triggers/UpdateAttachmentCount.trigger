trigger UpdateAttachmentCount on Case (after insert, after update) {
    if (checkRecursive.runOnce())
    {
        system.debug('UpdateAttachmentCount Trigger');
        List<Case> caseList = new List<Case>();
        Set<ID> caseIDSet = new Set<ID>();
        system.debug('update attachment count trigger');
        if (trigger.old != null)
        {
            for (Case c: trigger.old)
            {
                caseIDSet.add(c.ID);
            }
        }
        
        if (trigger.new != null)
        {
            for (case c: trigger.new)
            {
                caseIDSet.add(c.ID);
                system.debug('caseIDSet='+caseIDSet);
            }
        }
        
        // Query for the attachment children of the tasks
   
        
        for (case c: [SELECT id, (SELECT id FROM attachments) FROM Case WHERE ID in: caseIDSet])
        {
            c.AttachmentCount__c = c.Attachments.size();
            system.debug('c.AttachmentCount__c=='+ c.AttachmentCount__c);
        }
        
        update caseList;
        system.debug('caseList='+ caseList);
    }
}