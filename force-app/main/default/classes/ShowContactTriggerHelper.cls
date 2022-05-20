/*******************
 * 
 * 
 * 
 * opportunitylineitem = contact
 * Bundle_Components__r = Companies__r
 * 	Company__c
 * **********************************/

public class ShowContactTriggerHelper 
{
	 public static void createBulkConList(map<id,Contact> conmap,set<id> conids){
         list<contact> ConList = new list<contact>();
         list<Company__c> compList = new list<Company__c>();
         map<contact, list<Company__c>> conCompMap = new map<contact, list<Company__c>>();
         list<string> conRecCodes = new list<string>();
         for(Account accRec : [select id,(select id,name from contacts) from Account where id IN: conids]){
             for(contact conR : accRec.contacts){
                 
             }
         }
}
}