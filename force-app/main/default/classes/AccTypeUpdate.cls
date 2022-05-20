public class AccTypeUpdate {
    public static void afterUpdate(list<account> accList , map<id,account> oldaccmap){
        set<id> accIdSet = new set<id>();
             for(account accRec : accList){
            system.debug('accRec.Type ='+accRec.Type );
        system.debug('oldaccmap.get(accRec.Id).Type='+oldaccmap.get(accRec.Id).Type);
            if(accRec.Type != oldaccmap.get(accRec.Id).Type){
                accIdSet.add(accRec.Id);
            }
        }
        
        if(accIdSet.size() > 0){
            system.debug('accIdSet.size()='+accIdSet.size());
            list<messaging.Email> emails = new list<messaging.Email>();
            for(contact conRec : [SELECT id,LastName,Email,Account.name,Account.Type,Account.id FROM Contact WHERE Account.id  IN: accIdSet ]){
                
                list<string> toAdd = new list<string>{conRec.Email};
                
                //list<messaging.SingleEmailMessage> emails = new list<messaging.SingleEmailMessage>();  
                messaging.SingleEmailMessage message = new messaging.SingleEmailMessage();
                message.settoaddresses(toAdd);
                message.setsubject('Account Type changed');
                message.setplaintextbody('Account tpye is changed which is related to contact '+ conRec.lastname);
                emails.add(message);
            }
                try{
                Messaging.SendEmail(emails);
            }
            catch(Exception e){
                System.debug('-----Exception------' +e);        
            }

        }
    }
}