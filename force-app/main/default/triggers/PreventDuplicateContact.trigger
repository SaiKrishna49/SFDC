trigger PreventDuplicateContact on Contact (before insert,before update) {
    if(trigger.isInsert || trigger.isUpdate)
    {
        Map<String, Contact> emailMap = new Map<String, Contact>();
        
        for (Contact c : System.Trigger.new) 
        {
            if ((c.Email != null) && (System.Trigger.isInsert || (c.Email != System.Trigger.oldMap.get(c.Id).Email))) {
                if(emailMap.containsKey(c.Email)) {
                    c.Email.addError('Contact has the same Email address');
                }
                else {
                    emailMap.put(c.Email, c);
                }
            }            
            
        }
    
        for (Contact c : [SELECT Email FROM Contact WHERE Email IN :emailMap.KeySet()]) {
            Contact c1 = emailMap.get(c.Email);            
            c1.Email.addError('Contact with this email address already exists');
        }
    
    }
   
}