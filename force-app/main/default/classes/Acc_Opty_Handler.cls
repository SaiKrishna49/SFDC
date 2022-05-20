public class Acc_Opty_Handler {
    public static Void create(list<account> accounts){
        list<opportunity> optylist = new list<opportunity>();
        for(account a: accounts){
            if(a.rating == 'hot'){
                opportunity op = new opportunity();
				op.name= a.name;
				op.stagename = 'prospecting';
				op.CloseDate = system.today()+15;
				op.AccountId = a.Id;
				optylist.add(op);
            }
        }
        insert optylist;
    }

}