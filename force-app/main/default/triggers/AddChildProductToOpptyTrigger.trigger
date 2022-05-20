trigger AddChildProductToOpptyTrigger on OpportunityLineItem (after insert, after update)
{
    if(trigger.isinsert || trigger.isupdate){
      //  AddChildProductToOppty.createBulkopplineitems(Trigger.newMap);
    }
        
}