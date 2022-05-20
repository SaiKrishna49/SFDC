public class OppUpdAcc {
    public static void callme(list<opportunity> OppList){
        set<id> oppIdset = new set<id>();
        
        for(opportunity opp: OppList){
            oppIDset.add(opp.AccountId);
            system.debug('oppIDset=='+ oppIDset);
        }
        list<Account> AccList = [SELECT ID,Contacts_Counter__c,AnnualRevenue,(select id,AccountId,Amount from Opportunities)
                                 FROM Account Where Id In:oppIDset ];
           for(account a : AccList){
            a.Contacts_Counter__c = a.Opportunities.size();
            system.debug('a.Contacts_Counter__c='+a.Contacts_Counter__c);
            decimal sum=0;
            for(opportunity p: a.Opportunities){
                sum= sum+p.Amount;
                system.debug('sum ='+ sum);
             system.debug('p.Amount='+ p.Amount);
            }
            a.AnnualRevenue =sum;
            system.debug('a.AnnualRevenue='+ a.AnnualRevenue);
            system.debug('sum after for='+ sum);
        }
        update AccList;
    }

}