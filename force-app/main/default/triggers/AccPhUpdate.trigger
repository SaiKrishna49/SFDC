/* write a trigger to store the old value in contact phone number when account phone number is updated*/

trigger AccPhUpdate on Account (after update) {
    //map<id,phone> AccMap = new map<id,phone>();
    set<id> accIds = new set<id>();
    set<id> conIds = new set<id>();
    for(account Acc : trigger.old){
        accIds.add(Acc.id);
    }
    list<Account> Acclist =[SELECT Id,phone,industry,(SELECT id,phone from contacts) from Account where Id IN : accIds];
    contact c = new contact();
    for(account A : Acclist){
        //c.LastName = a.id;
        c.phone = A.Phone;
    }
    update c;
}