public class AccOppTriggerHandler 
{
    Public static void AccOpp(List<account> Acclist)
    {
       list<opportunity> optylist = new list<opportunity>();
        for(account acc : Acclist)
        {
            if(acc.rating == 'HOT')
            {
                opportunity opp = new opportunity();
                opp.AccountId = acc.Id;
                opp.Name = acc.Name;
                opp.StageName = 'Prospecting';
                opp.CloseDate = system.today() + 15;
                opp.Type = 'new customer';
                opp.Description = 'Opp created from account with Acc id '+ acc.Id;
                optylist.add(opp);
            }
        }
        insert optylist;
    }
}