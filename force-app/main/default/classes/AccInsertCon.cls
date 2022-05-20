public class AccInsertCon {
    public static void Callme(List<Account> Accounts){
        list<contact> conList = new list<contact>();
        for(account Acc: Accounts){
            contact c = new contact();
            c.LastName = Acc.name;
            c.AccountId = Acc.id;
            c.Phone = Acc.Phone;
            c.MailingCity = Acc.BillingCity;
            conList.add(c);
        }
        Insert conList;
    }

}