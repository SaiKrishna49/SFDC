trigger ContactActionPicklist on Account (before insert,before update,before delete,after insert,after update,after delete) {
    set<id> accIds = new set<id>();
    list<contact> ConList = new list<contact>();
    list<Account> ACClist = new list<Account>();
    if(trigger.isafter){
        if(trigger.isInsert || trigger.isUpdate){
            for(Account ACC : trigger.new){
                accIds.add(ACC.Id);
            }
            if(trigger.isdelete){
                for(account Acc : trigger.old){
                    accIds.add(ACC.Id);
                }
            }
        }
        
        for(account Acc: trigger.new){
            if(Acc.Contact_Action__c == 'new'){
                system.debug('Acc.Contact_Action__c=='+ Acc.Contact_Action__c);
                contact con = new contact();
                con.LastName = 'Contact Action new';
                con.AccountId = Acc.Id;
                system.debug('con.LastName =='+ con.LastName );
                insert con;
            }
            else if(Acc.Contact_Action__c == 'clone'){
                contact con = new contact();
                con.LastName = Acc.Id;
                con.AccountId = Acc.Id;
                system.debug('con.LastName =='+ con.LastName );
                insert con;
            }
        }
   
               
    }
}






















/* for(Account Acc: trigger.old){
            if(Acc.Contact_Action__c == 'delete'){
                
                ACClist=[SELECT ID,Contact_Action__c from Account Where Id in:accIds ];
                system.debug('ACClist=='+ ACClist);
                contact c = new contact();
               ConList = [SELECT ID from contact];
            } 
        }
            
            for(Account Accnt : ACClist){
                delete Accnt;
                system.debug('delete Accnt=='+ Accnt);
            }  */



/* For(Account Acc: trigger.old){
            if(Acc.Contact_Action__c = 'delete')
            conta--ct con = new contact();
                con.LastName = Acc.Id;
                con.AccountId = Acc.Id;
                system.debug('con.LastName =='+ con.LastName );
                insert con;
        }*/
   /*     ACClist = [SELECT id,name,Contact_Action__c FROM Account WHERE ID IN:accIds ];
        
        if(ACClist.size()> 0){
            system.debug('ACClist.size()=='+ ACClist.size());
          // Account Ac = new Account();
            For(Account Ac : trigger.new){
                if(Ac.Contact_Action__c == 'new'){
                    system.debug('Ac.Contact_Action__c=='+ Ac.Contact_Action__c);
                    contact Con = new contact();
               con.LastName = Ac.Name;
                con.AccountId = Ac.Id;
               con.FirstName = 'cccccc';
                con.Phone = '214578963';
                con.Description = 'Created from Acoount contact Action picklist';
                ConList.add(con);
            }
            
                
            }
            update ConList;
            insert conlist;
        }
        update ACClist;
        
    }*/