trigger PhUpdate on Account (after update) {
    list<contact> clist = new list<contact>();
    set<id> accIds = new set<id>();
    set<id> conIds = new set<id>();
    for(account Acc : trigger.old){
        accIds.add(Acc.id);
    }
    list<Account> Acclist =[SELECT Id,phone,industry,(SELECT id,phone from contacts) from Account where Id IN : accIds];
    contact c = new contact();
    for(account A : Acclist){
        if(c.accountid == A.id){
            c.phone = A.Phone;
            clist.add(c);
        }
        //c.LastName = a.id;
        
    }
    update clist;
}
/*  list<contact> conlist = new list<contact>();
    set<id> ids = new set<id>();
    for(account acc : Trigger.new){
        ids.add(acc.id);
        system.debug('ids='+ids);
    }
    contact con = new contact();
    conlist = [Select id,phone,accountid FROM contact where accountid IN:ids] ;
    system.debug('conlist='+conlist);
    for(contact con : conlist ){
        for(account acc : Trigger.new){
        if(con.accountid == acc.id){
            system.debug('con.accountid=='+con.accountid);
            con.phone =acc.phone;
            system.debug('con.phone=='+con.phone );
            conlist.add(con);
    }
    
        }
    }
    update conlist;*/