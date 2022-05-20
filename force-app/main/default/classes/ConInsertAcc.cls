public class ConInsertAcc {
    Public static Void callme(List<contact> contacts){
        list<account> AccList = new list<account>();
        for(contact con :contacts ){
            Account Acc = new Account();
            Acc.Name = con.LastName;
            Acc.Id = con.AccountId;
            Acc.BillingCity = con.MailingCity;
            Acc.Description = 'This Account is created by conInsertAcc Trigger with Con Id'+ con.Id;
            AccList.add(Acc);
        }
        Insert AccList;
    }
}