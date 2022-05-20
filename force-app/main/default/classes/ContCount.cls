public class ContCount 
{
    public static void CountContacts(List<contact> contacts)
    {
        set<id> accids = new set<id>();
        for(contact c: contacts)
        {
            accids.add(c.AccountId);
        }
        list<account> accList = [SELECT id,(SELECT id FROM contacts) FROM account WHERE id in:accids];
        map<id,integer> AccMap = new map<id,integer>();
        for(account acc : accList)
        {
            integer count = acc.contacts.size();
            AccMap.put(acc.id,count);
        }
        for(contact con : contacts)
        {
            integer count=AccMap.get(con.AccountId);
            if(count > 2){
                con.addError('We can not create more than 2 contacts for an account');
            }
        }
    }
}