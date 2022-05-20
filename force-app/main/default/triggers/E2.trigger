trigger E2 on Contact (after insert,after update) {
    list<account> alist = new list<account>();
    set<id> ids = new set<id>();
    
    for(contact c : Trigger.new){
        ids.add(c.AccountId);
    }
    map<id,account> accmap = new map<id,account>([Select id,phone from account where id In: ids]);
    for(contact c : trigger.new){
        account a = accmap.get(c.AccountId);
        if(a!= null){
            a.phone = c.Phone;
            alist.add(a);
        }
        update alist;
    }
       
}