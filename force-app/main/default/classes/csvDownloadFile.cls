public class csvDownloadFile {
@AuraEnabled
   public static list <contact> fetchContactRecord(){
      
      List <contact> returnConList = new List < contact > ();
        
      for(contact con: [SELECT firstName, LastName, Department, MobilePhone From contact LIMIT 500]) {
             returnConList.add(con);
          }
         return returnConList;
   }
}