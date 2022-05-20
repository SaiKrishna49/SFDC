public class OppCountTriggerHandler 
{
	public static void OppCount(list<opportunity> opptys)
    {
        set<id> accids = new set<id>();
        for(opportunity opp : opptys)
        {
            if(opp.accountId != null)
            {
                accids.add(opp.accountId);
            }
        }
        list<account> Acclist = [SELECT id,(SELECT id FROM Opportunities) FROM account WHERE id in:accids ];
        map<id,integer> accMap = new map<id,integer>();
        for(account acc : Acclist)
        {
           // integer count = acc.Opportunities.size();
           list<opportunity> oplist = acc.Opportunities;
            
            system.debug('acc.Opportunities.size() =='+ oplist.size());
            accMap.put(acc.id, oplist.size());
        }
        for(opportunity op : opptys)
        {
           // integer count = accMap.get(op.id);
           Id parentId = op.AccountId;
            integer count = accMap.get(parentId);
            system.debug('count=='+ count);
            if(count >= 5)
            {
                op.addError('Can not Add more than 5 opportunites for account');
            }
        }
    }
}