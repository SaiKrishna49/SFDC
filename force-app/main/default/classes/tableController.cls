public with sharing class tableController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, AnnualRevenue, Industry, Phone from Account];
    }
}