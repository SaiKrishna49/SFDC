public class MyContactListController {
@AuraEnabled
    public static list<contact> getcontacts(id recordId){
        return[SELECT id,email,firstname,lastname,phone FROM contact WHERE AccountID=: recordId ];
    }
}