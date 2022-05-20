trigger UpdateCaseStatusTrigger on Case (after insert, after update) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert || Trigger.isUpdate) {
            UpdateCaseStatusHandler.updateCase(Trigger.new);
        }
    }
}