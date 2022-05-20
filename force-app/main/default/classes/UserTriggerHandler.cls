public class UserTriggerHandler {
    public static void assignPermission(list<user> userList){
        system.debug('userList =='+userList);
        set<id> userIdSet = new set<id>();
        list<permissionsetassignment> permissionsetList = new list<permissionsetassignment>();
        for(user u : userList){
            userIdSet.add(u.id);
            system.debug('userIdSet=='+ userIdSet);
        }
        system.debug('userIdSet.size()=='+userIdSet.size());
        if(userIdSet.size()>0){
            for(user userRec : [SELECT id,name,profileid,profile.name FROM user WHERE id IN: userIdSet AND profile.name = 'Platform user clone']){
                for(PermissionSetGroup  rec: [SELECT DeveloperName, Id, MasterLabel, NamespacePrefix FROM PermissionSetGroup ]){
                    //profile id given is "Platform user clone" ==> 00e5g000000M0KqAAK
                    system.debug('userRec=='+ userRec);
                    PermissionSetAssignment assignPermissionset = new PermissionSetAssignment();
                    assignPermissionset.PermissionSetGroupId = rec.Id;
                    system.debug('rec.Id='+rec.Id);
                    //permission set group  assigned name is "group1"
                    assignPermissionset.AssigneeId = userRec.Id;
                    permissionsetList.add(assignPermissionset);
                    system.debug('permissionsetList after add=='+ permissionsetList);
                }
            }
        }
        try{
            INSERT permissionsetList;
            system.debug('permissionsetList after update=='+ permissionsetList);
        }catch(exception e){
            system.debug('error ='+ e.getDmlMessage(0)); 
        } 
    } 
}