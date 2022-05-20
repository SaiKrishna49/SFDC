public class AccRelatedConC{    
    @AuraEnabled
    public static List<Account> fetchAcc (){
        return [SELECT Id, Name, Phone FROM Account limit:5];
    }    
    @AuraEnabled
    public static List<Contact> fetchCon (String recordId){
        return [SELECT Id, Name,title,email,Phone FROM Contact WHERE AccountId=:recordId];
    }
}