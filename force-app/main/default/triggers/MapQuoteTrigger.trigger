trigger MapQuoteTrigger on Opportunity (after update) {
    if(Trigger.isafter && Trigger.isupdate ){
        //updating Quote ID to Case
      MapQuoteClass.QuoteID(Trigger.new, Trigger.oldmap , Trigger.newmap);
    }
 }