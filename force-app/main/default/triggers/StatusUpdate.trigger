trigger StatusUpdate on Traning__c (Before insert,before update) {
         TrainingStatus.UpdateStatus(Trigger.new);

}