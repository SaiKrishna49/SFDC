public class RestrictDuplicateContactTriggerHandler {
    public static void check(list<contact> newConList){
        Set<id> accId = new Set<id>();
        for(contact con : newConList){
            if(con.AccountId != null){
                accId.add(con.AccountId);    
            }
        }
        Map<Id,Account> accMap = new Map<Id,Account> ( [SELECT id,(SELECT id from contacts) FROM account WHERE id IN : accId ]) ;
        for(contact conRec : newConList)
        {	
            if( conRec.AccountId != null && accMap.containsKey(conRec.AccountId) )
            {
                Account acc = accMap.get(conRec.AccountId);
                if(acc.Contacts.size() > 1 )
                {
                    conRec.addError('you can have only one contact associated to one Account'); 
                }
            }
        }
    }
}
  /*  public static void Check(List<contact> newConList){
        Set<id> accId = new Set<id>();
        List<contact> conList = new List<contact>();
        for(contact con : newConList){
            if(con.AccountId != null){
                accId.add(con.AccountId);    
            }
        }
        if(accId.size() > 0){
            for(account accRec : [SELECT id,(SELECT id FROM contacts) FROM account WHERE id IN : accId] ){
                for(contact conRec : accRec.contacts){     
                    conList.add(conRec);
                }
            }
            for(contact ContRec:newConList){   
                if(conList.size() > 1 ){
                    ContRec.addError('you cant add more then one contact for this account'); 
                }
            }
        }
    } 
}
*/


/*
 * 
 * trigger FindDuplicateContact on Contact (before insert) 
{
	Set<id> accId = new Set<id>(); // Always try to use set
	for(contact cc : trigger.new)
	{
		if(cc.AccountId != null)
		{
			accId.add(cc.AccountId);    
		}
	}

	Map<Id,Account> mapAccount = new Map<Id,Account> ( [select id,(select id from contacts) from account where id IN : accId ) ;
	for(contact oCon:trigger.new)
	{	
		if( oCon.AccountId != null && mapAccount.containsKey(oCon.AccountId) )
		{
			Account acc = mapAccount.get(oCon.AccountId);
			if(acc.Contacts.size() > 0 )
			{
				oCon.addError('you can not add more then once contact for this account'); 
			}
		}
	}
}
*
*/