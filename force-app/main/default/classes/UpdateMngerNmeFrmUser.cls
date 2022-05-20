public class UpdateMngerNmeFrmUser {
    public static void updateManager(list<user> newUserList, map<id,user> oldUserList){
 //Variables
    Set<Id> userIds = New Set<Id>();
    String managerName;
    String varmanagerId;
        
    //For Loop to get the manager ID
    for(User usr: newUserList){
        if(!String.isBlank(oldUserList.get(usr.Id).ManagerId) && usr.ManagerId != oldUserList.get(usr.Id).ManagerId){
            userIds.add(usr.id);
            varmanagerId = oldUserList.get(usr.Id).ManagerId;
    }
       
    //For loop to get the Manager Name
    for(user usrlist : [select id,Name from user where id =:varmanagerId]){
        managerName = (string)usrlist.Name;
    }
    //List of accounts that needs to be updated.
    List<account> updateAcc = new List<account>();
    //For Loop on Accounts to update the Manager Name
    for(Account acc: [SELECT Id, Name, OwnerId, Manager_Name__c FROM Account Where OwnerId in: userIds]){
        acc.Manager_Name__c = managerName;
        system.debug('Accont Manager Name:'+acc.Manager_Name__c);
        updateAcc.add(acc);
    }
    //If the Account List has more than zero records or not empty update the list.
    if(!updateAcc.isEmpty() && updateAcc.size()>0){
        try{
            update updateAcc;
        }catch(exception e){
            system.debug(e.getMessage());
        }
    }
}
}
}