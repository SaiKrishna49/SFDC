public class Acc_BackUp_Class {
    public static void callme(list<account> Accounts){
        set<id> AccIdSet = new set<id>();
        list<account> Acclist = new list<account>();
        list<Account> BackUpAcc = new list<Account>();
        List<contact> BackUpCon = new List<Contact>();
        list<opportunity> BackupOpp = new list<opportunity>();
        for(account Acc: Accounts){
            AccIdSet.add(acc.id);
            system.debug('AccIdSet='+ AccIdSet);
        }
        Acclist=[SELECT Id,number_of_contacts__c,(SELECT ID,accountId FROM contacts) FROM account WHERE ID In:AccIdSet ];
        system.debug('Acclist=='+ Acclist);
        for(account a:Acclist){
            a.number_of_contacts__c = Acclist.size();
        system.debug('Acclist.size()='+Acclist.size());
            system.debug(' a.number_of_contacts__c='+  a.number_of_contacts__c);
        if(Acclist.size() > 3){
            system.debug('enterend if');
            Account Acct = new Account();
            Acct.Name = a.Name;
            Acct.ParentId = a.Id;
            Acct.Description = 'This Account is created as a backup account when number of related contacts are more than 3 from account with ID'+a.Id;
            BackUpAcc.add(Acct);
            //contact con = new contact();
         	//con.LastName = a.
            opportunity opp = new opportunity();
            opp.Name = a.Name;
            opp.AccountId = a.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = system.today() + 20;
            opp.Description = 'This Opp is created from Account backup class with accid ='+a.Id;
            BackupOpp.add(opp);
        }
      }
        insert BackUpAcc;
        system.debug('BackUpAcc=='+ BackUpAcc);
        insert BackupOpp;
        system.debug('BackupOpp=='+ BackupOpp);
    }

}