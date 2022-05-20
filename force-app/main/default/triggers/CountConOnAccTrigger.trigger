trigger CountConOnAccTrigger on Contact (after insert, after update, after delete, after undelete)
{
    
    if(Trigger.isinsert || Trigger.isundelete){
        CountConOnAccClass.GetAccContacts(Trigger.New, Trigger.old);
    }
    if(Trigger.isupdate || Trigger.isdelete){
        CountConOnAccClass.GetAccContacts(Trigger.New, Trigger.old);
    }
   
}