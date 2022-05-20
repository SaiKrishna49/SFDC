trigger E1 on Account (after update) {
    Set <Id> accountIdSet = new Set <Id>();
    Map <Id,String> accountMap = new Map <Id,string> ();
    for(Account acc:trigger.new) {
        if(Trigger.oldMap.get(acc.Id).phone != acc.phone) {
            accountIdSet.add(acc.id);
        }
        if(acc.phone != null) {
            accountMap.put(acc.id,acc.phone);
        }
    }
    List <contact> contactList = new List <Contact>();
    for(Contact con:[select id,accountId,Phone from contact where accountId in:accountIdSet]) {
        if(accountMap != null && accountMap.containsKey(con.accountId)) {
            con.phone = accountMap.get(con.accountId);
            contactList.add(con);
        }
    }
    if(contactList.size() >0) {
        update contactList;
    }

}