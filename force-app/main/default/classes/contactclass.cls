public class contactclass {
    @AuraEnabled(Cacheable = true)
    public static Boolean checkinContact(string conEmail){
        Boolean condition = false;
        List<Contact> con = [SELECT id,Name,Email FROM Contact where Email =:conEmail];
        if(con.size()>0){
            condition = true;
        }
        else{
            condition = false;
        }
        system.debug(condition);
        return condition;   
    }  
}