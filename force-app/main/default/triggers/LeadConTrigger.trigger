trigger LeadConTrigger on Lead (after insert) 
{
    if(trigger.isafter && trigger.isinsert)
    {
       // list<lead> leads = Trigger.new;
        LeadConTriggerHandler.createCon(Trigger.new);
    }
}