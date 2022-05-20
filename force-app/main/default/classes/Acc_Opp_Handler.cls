public class Acc_Opp_Handler {
    Public static void callme(list<Account> Accounts){
        list<opportunity> OptyList = new List<opportunity>();
        for(Account A : Accounts){
            if(A.Industry == 'Banking'){
                opportunity Opp = new opportunity();
                opp.Name = a.name;
                Opp.AccountId = a.id;
                opp.StageName = 'Prospecting';
                opp.CloseDate = system.today()+20;
                opp.Description = 'This Record is created from Acc_Opp_Handler class from account with ID='+a.id;
                OptyList.add(opp);
            }
        }
        Insert OptyList;
    }

}