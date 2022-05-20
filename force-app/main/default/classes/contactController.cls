public with sharing class contactController {
    @AuraEnabled
    public static list<contact> findcontactbyAccountId(string accountId){
        return [
            SELECT id,FirstName,LastName,Email,phone 
            FROM contact
            WHERE AccountId=:accountId
            LIMIT 10];

    }
}