trigger AcccHandler on Account_Plan__c (after insert, after update, after delete, after undelete)
{system.debug('trigger before iff');
      if(trigger.isInsert || trigger.isUpdate){
         system.debug('trigger after ifff');
        Accc.method1(trigger.new,trigger.old);
          system.debug('trigger.neww'+ trigger.new );
          system.debug('trig.old'+ trigger.old );
    }
}