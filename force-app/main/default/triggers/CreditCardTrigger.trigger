trigger CreditCardTrigger on Credit_Card__c (After insert) {
CreditCardTriggerHandler.onBeforeInsert(Trigger.newmap);
}