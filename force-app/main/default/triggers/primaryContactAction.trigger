trigger primaryContactAction on Contact (after update,after insert) 
{
    PrimaryContactOnInsert.ContactOnInsert(trigger.new);
}