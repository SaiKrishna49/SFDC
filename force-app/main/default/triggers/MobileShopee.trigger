trigger MobileShopee on Mobile__c (Before insert,Before Update) {
    if(trigger.isinsert == true){
        MobileShopeeclass.NewCustomerDiscount(Trigger.new);
    }
    if(trigger.isupdate == true){
        MobileShopeeClass.OldCustomerDiscount(Trigger.new);
    }
 }