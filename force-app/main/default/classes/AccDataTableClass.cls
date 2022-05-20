public with sharing class AccDataTableClass {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccList(){
        try {
            return [SELECT Id, Name, Type, Rating, Phone, Website, AnnualRevenue FROM Account LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}