trigger ContactTrigger on Contact (After insert, After update, After delete, After undelete) 
{
    if(Trigger.isUpdate)
    {
      /*  system.debug('Trigger.isUpdate='+ Trigger.isUpdate);
        ContactTriggerHandler.GetUpdatedCon(Trigger.new , Trigger.oldmap);*/
        
    }
    else if(Trigger.isdelete)
    {
       /* system.debug('Trigger.isdelete='+ Trigger.isdelete);
        ContactTriggerHandler.GetAccountContact(Trigger.old);*/
    }
    else {
      /*  System.debug('Trigger insert and undelete');
        ContactTriggerHandler.GetAccountContact(Trigger.new);*/
         
        
    }
}