public with sharing class lwcEditSaveRowCtrl {

    @AuraEnabled(Cacheable = true)
    public static List<Account> getAccounts() {

        List<Account> accList = [SELECT Id, Name, Phone, Industry, Type, Website, Description FROM Account WHERE Phone != null AND Industry != null ORDER BY CreatedDate DESC ];

        return accList;
    }    
}