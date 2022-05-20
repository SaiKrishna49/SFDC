public class Accc {
    Public static void method1(list<Account_Plan__c> newInsert , list<Account_Plan__c> oldInsert){
        set<id> AccIdset = new set<id>();
        for(Account_Plan__c Ap : newinsert){
            if(Ap.Id == null)continue;
           if(oldInsert == null || (oldInsert != null /*&& oldInsert.get(Ap.id).signed__c != Ap.signed__c*/)){
                AccIdset.add(Ap.Id);
               system.debug('AccIdset======'+ AccIdset);
            }
        }
        system.debug('before return');
        if(AccIdset.isEmpty())return;
        system.debug('after return');
        List<Account> accList =[SELECT id, Account_status__c,
                                	(SELECT Id, signed__c FROM Account_plan__r WHERE signed__c = True ) 
                                	FROM Account WHERE id IN :AccIdset];
        system.debug('accList===='+ accList);
          for(Account acc : accList)
        {
           system.debug('*********');
            system.debug('acc.Account_Status__c=='+acc.Account_Status__c);
                acc.Account_Status__c = 'Completed';
            system.debug('acc.Account_Status__c=='+acc.Account_Status__c);
                
            
        }
        update accList;
        system.debug('updated acclist=='+accList );
    }
    
}