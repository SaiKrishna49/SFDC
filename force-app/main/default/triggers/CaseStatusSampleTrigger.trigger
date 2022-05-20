trigger CaseStatusSampleTrigger on Case (after insert, after update) {
    if(trigger.isafter && trigger.isupdate){
        CaseStatusSampleHandler.updateChildCaseStatus(Trigger.new, Trigger.oldmap);        
    }

    
}