trigger ContountTrigger on Contact (before insert) 
{
    if(trigger.isbefore && trigger.isinsert)
    {
        list<contact> contacts = Trigger.new;
        ContCount.CountContacts(contacts);
    }
}