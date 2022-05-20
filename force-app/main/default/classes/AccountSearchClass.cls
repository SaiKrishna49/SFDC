public class AccountSearchClass 
{
	@AuraEnabled
    Public static list<account> SearchAcc(string st)
    {
        String Query = 'Select name,phone,industry,fax FROM Account WHERE name LIKE \'%'+st+'%\'';
            list<Account> accounts = Database.query(Query);
        Return accounts;
    }
}