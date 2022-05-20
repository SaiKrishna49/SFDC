trigger UpdAccBillAdd on Account (after update){
  List<Contact> accList = new List<Contact>();
    Map<Id,List<Contact>> AccountMap = new Map<Id,List<Contact>>();

    if(Trigger.isUpdate){

        for(Contact con : [SELECT Id,AccountId FROM Contact WHERE AccountId IN :Trigger.newMap.keySet()])

            if(!AccountMap.containskey(con.AccountId)){
                AccountMap.put(con.AccountId,new List<Contact>());
            
            AccountMap.get(con.AccountId).add(con); 
        }
    }
    for(Account c:Trigger.new) {

        system.debug('hfeffht'+c.ID);

        if(!AccountMap.containskey(c.Id)) { //code for insert only

            Contact con = new Contact(LastName=c.Name,
                                MailingStreet=c.BillingStreet,
                                MailingCity=c.BillingCity,
                                MailingPostalCode=c.BillingPostalCode,
                                MailingCountry=c.BillingCountry,
                                AccountId=c.ID);
            accList.add(con);
            system.debug('AccountId'+con.AccountId);

         }else { //code for update account

            for(Contact con : AccountMap.get(c.Id)){ //get all contacts under account and update.

                con.MailingCity = c.BillingCity;
                con.MailingPostalCode = c.BillingPostalCode;
                con.MailingCountry = c.BillingCountry;
                accList.add(con);
            }
         }
    }


    try {
        upsert accList;
    } catch (Exception ex) {
        System.debug('Could not update Last Survey Sent field on Account with cause: ' + ex.getCause());
    }   
               }

    
    
    
    
    
    /*List<Contact> Conlist = new List<Contact> ();
    for(Contact c : [SELECT Name,Id,Phone,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry From Contact Where AccountId IN: Trigger.New]){
       Account a = new Account();
        a = Trigger.newMap.get(c.AccountId);
        c.MailingStreet     = a.BillingStreet;
        c.MailingCity       = a.BillingCity;
        c.MailingState      = a.BillingState;
        c.MailingPostalCode = a.BillingPostalCode;
        c.MailingCountry    = a.BillingCountry;
        Conlist.add(c);
    }
    update Conlist;
}
*/

/*{
    set<Id> AccIdsSet = new set<Id>();
    
    if(trigger.isupdate){
        for(Account Acc : trigger.new){
            AccIdsSet.add(Acc.id);
        }
        
    }
    list<Account> AccList = new list<Account>();
    AccList = [SELECT ID,Name,BillingStreet,BillingCity,BillingState,BillingCountry,BillingPostalCode,(SELECT ID,Name FROM contacts) From Account WHERE ID IN:AccIdsSet ];
    contact con = new contact();
    for(account A : AccList){
        con.MailingStreet  = A.BillingStreet ;
        con.MailingCity    = A.BillingCity;
        con.MailingState   = A.BillingState;
        con.MailingCountry = A.BillingCountry;
        con.MailingPostalCode = A.BillingPostalCode; 
    }
    update con;
    update AccList;
}*/