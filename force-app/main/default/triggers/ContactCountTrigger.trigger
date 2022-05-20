trigger ContactCountTrigger on Contact (after insert, after update, after delete, after undelete) 
{
    if(Trigger.isinsert || Trigger.isundelete){
        ContactCountTriggerHandlerClass.GetAccCon(Trigger.New);
    }
    if(Trigger.isupdate || Trigger.isdelete){
        ContactCountTriggerHandlerClass.GetAccCon(Trigger.old);
    }
}