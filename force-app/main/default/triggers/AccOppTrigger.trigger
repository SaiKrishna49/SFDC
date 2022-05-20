trigger AccOppTrigger on Account (after insert) 
{
    if(trigger.isafter && trigger.isinsert)
    {
        List<account> Acclist = Trigger.new;
        AccOppTriggerHandler.AccOpp(Acclist);
    }
}