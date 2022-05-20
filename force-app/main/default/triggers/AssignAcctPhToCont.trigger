/*Write a trigger while creating a new contact assign account phone number to 
new contact and show account phone number in created contact record*/


trigger AssignAcctPhToCont on Account (after insert, after update) {
    set<id> AccIds = new set<id>();
    set<id> conIds = new set<id>();
    if(trigger.isinsert || trigger.isupdate){
        for(Account Acc:trigger.new){
        AccIds.add(Acc.id);
    }
    }
    list<account> Acclist = [SELECT Id,name,Phone,(SELECT ID,lastname,phone FROM contacts) FROM Account where ID IN:AccIds];
    contact c = new contact();
    for(Account a :Acclist){
        c.AccountId = a.Id;
        c.LastName = a.name;
        c.phone = a.phone;
        c.description = 'AssignAcctPhtoCont  trigger';
    }
    insert c;
   // update Acclist;
}