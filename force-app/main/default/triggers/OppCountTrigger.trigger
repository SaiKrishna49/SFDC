trigger OppCountTrigger on Opportunity (before insert) 
{
    if(trigger.isbefore && trigger.isinsert)
    {
        list<opportunity> opptys = Trigger.new;
        OppCountTriggerHandler.OppCount(opptys);
    }
}