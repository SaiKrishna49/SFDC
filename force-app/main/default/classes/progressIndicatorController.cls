public class progressIndicatorController {
 @AuraEnabled
    public static Lead updateLeadStatus(string Id, string status){
        try {
            Lead leadRecords=new Lead();
            leadRecords.Id=id;
            leadRecords.CustomStatus__c=status;

            update leadRecords;
            return leadRecords;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}