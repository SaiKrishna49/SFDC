public class AddConToAcc {
    public static void getchildCon(map<id,contact> ConMap ){
        set<id> AccIdSet = new set<id>();
        list<contact> ConList = new list<contact>();
        list<Family__c> Familylist = new list<Family__c>();
        map<contact, list<Family__c>> FamilyListMap = new map<contact, list<Family__c>>();
        list<string> AccConIds = new list<string>();
        for(Account Acc : [SELECT id,(SELECT id FROM contacts) FROM Account WHERE id IN: AccIdSet]){
            for(contact con: Acc.contacts){
                AccConIds.add(con.id);
            }
        }
        for(contact conRec : [SELECT id,name,(SELECT id,name FROM Familes__r)
                              FROM contact WHERE id In :ConMap.keySet() AND IsActive__c =: TRUE]){
                                  if(conRec.Familes__r.size() > 0){
                                      for(Family__c  familyRec : conRec.Familes__r){
                                          if(FamilyListMap.containskey(ConMap.get(conRec.id))){
                                              list<Family__c> families = FamilyListMap.get(ConMap.get(conRec.Id));
                                              families.add(familyRec);
                                              FamilyListMap.put(ConMap.get(conRec.Id),families);
                                          }
                                          else{
                                              list<Family__c> famlyList =new list<Family__c>();
                                              famlyList.add(familyRec);
                                              FamilyListMap.put(ConMap.get(conRec.Id), famlyList );
                                          }
                                          
                                      }
                                  }
                                  
                              }         
        map<contact,set<id>> conmapIds = new map<contact,set<id>>();
        for(contact conRecc : FamilyListMap.keyset()){
            for(family__c  famRec : FamilyListMap.get(conRecc)){
                if(conmapIds.containskey(conRecc)){
                    set<id> Familyids = conmapIds.get(conRecc);
                    Familyids.add(famRec.id);
                    conmapIds.put(conRecc,Familyids);
                }
                else{
                    conmapIds.put(conRecc,new set<id> {famRec.Id});
                }
            }
        }
        list<contact> contList = new list<contact>();
        for(contact conRecc : conmapIds.keyset()){
            for(family__c FamlRec : [SELECT id,Contact__r.id FROM family__c WHERE Id IN:conmapIds.get(conRecc)]){
                contact conn = new contact();
                conn.AccountId = conRecc.AccountId;
                contList.add(conn);
            }
        }
        
        
        if(contList.size() > 0){
            INSERT contList;
            system.debug('contList='+ contList);
        }
    }
}