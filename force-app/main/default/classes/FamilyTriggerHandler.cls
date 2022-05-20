/**************************************************************************************************
*** Class Name             : FamilyTriggerHandler
*** Class Description      : This class is used to add contact child object i.e.Family object to account object 
							 which is linked to that contact.
*** Author                 : Krishna
*** Class Created Date     : 08-Nov-2021
**************************************************************************************************/

public class FamilyTriggerHandler {
    public static void addParentConToAcc(map<id,Family__c> familyMap){
        list<Family__c> familyListToUpdate = new list<Family__c>();
        for(Family__c familyRec : [SELECT id,Contact__c,Contact__r.id,Contact__r.accountId,Account__c,IsActive__c 
									FROM Family__c WHERE IsActive__c = TRUE AND id IN:familyMap.keyset()]){
            if(familyRec.Contact__r.accountId != NULL ){
            familyRec.Account__c = familyRec.Contact__r.accountId;
            familyListToUpdate.add(familyRec);
                }
        }
        if(familyListToUpdate.size() > 0){
            UPDATE familyListToUpdate;
            
        }
        
    }
    public static void updateAcc(map<id,Family__c> newFamilyMap , map<id,Family__c> oldFamilyMap){
        system.debug('UPDATE ACC METHOD');
        set<id> familyIdSet = new set<id>();
        list<Family__c> familyListToUpdate = new list<Family__c>();
             for(Family__c familyRec : [SELECT id,Contact__c,Contact__r.id,Contact__r.accountId,Account__c,IsActive__c 
									FROM Family__c WHERE IsActive__c = TRUE AND id IN:newFamilyMap.keyset()]){
                                        system.debug('familyRec in for loop=='+familyRec);
                              system.debug('familyRec.Contact__r.accountId=='+familyRec.Contact__r.accountId);          
            if(familyRec.Contact__r.accountId != NULL && familyRec.Contact__c != oldFamilyMap.get(familyRec.Id).contact__c){
            familyRec.Account__c = familyRec.Contact__r.accountId;
                system.debug('familyRec.Account__c=='+ familyRec.Account__c);
            familyListToUpdate.add(familyRec);
                }
        }
             if(familyListToUpdate.size() > 0){
            UPDATE familyListToUpdate;
            system.debug('familyListToUpdate=='+ familyListToUpdate);
        }
    }

}