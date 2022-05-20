public Class AccountTriggerHandler{
      public AccountTriggerHandler(){
      }
      
      public void onAfterUpdate(Map<Id,Account> newMapAccount,Map<Id,Account> oldMapAccount){
           List<Account> fetchAccountList = new List<Account>();
           
           for(Id accMap:newMapAccount.keyset()){
               if(newMapAccount.get(accMap).Phone <> oldMapAccount.get(accMap).phone){
                  fetchAccountList.add(newMapAccount.get(accMap));
               }
           }
           Map<ID,Account> fetchAccContacttList = new Map<Id,Account>([Select Id,Phone,(Select Id,Phone from Contacts) from Account where Id in:fetchAccountList]);
           Map<Id,List<Contact>> fetchContacts = new Map<Id,List<Contact>>();
           for(Account acclIst:fetchAccContacttList.values() ){
               if(!accList.contacts.isEmpty()){
                  fetchContacts.put(acclIst.Id,acclIst.contacts);
               }
           }
           List<Contact> contactUpdate = new List<Contact>();
           for(Id cseId:fetchContacts.keyset()){
               List<Contact> contactsList = new List<Contact>();
               contactsList = fetchContacts.get(cseId);
               for(Contact cnts:contactsList){
                 
                   Account acc= fetchAccContacttList.get(cseId);
                   
                   cnts.phone = acc.Phone;
                   contactUpdate.add(cnts);
               }
           }
           
           update contactUpdate;
     }
}