trigger Acc_BackUp_Class_TriggerHandler on Account (After insert, after Update) {
    if(trigger.isInsert || trigger.isupdate){
        Acc_BackUp_Class.callme(Trigger.new);
    }

}