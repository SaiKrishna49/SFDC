/*
Description: On Account create a field "Manager name". Whenever manager field is updated on user,
update the field "Manager name" on Account to the manager present on user.
Date:04/19/2022
*/
trigger UpdateMngerNmeFrmUser on User (After Update) {
   
     //Variables
    Set<Id> userIds = New Set<Id>();
    String managerName;
    String managerId;
    //For Loop to get the manager ID
    for(User usr: trigger.new){
        if(!String.isBlank(trigger.oldMap.get(usr.Id).ManagerId) && usr.ManagerId != trigger.oldMap.get(usr.Id).ManagerId){
            userIds.add(usr.id);
            managerId = (string)trigger.oldMap.get(usr.Id).ManagerId;
        }
    }
    //For loop to get the Manager Name
    for(user usr : [select id,Name from user where id =:managerId]){
        managerName = (string)usr.Name;
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