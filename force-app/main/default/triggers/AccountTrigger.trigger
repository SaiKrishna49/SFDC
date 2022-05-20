trigger AccountTrigger on Account (after Update) {

		AccTypeUpdate.afterUpdate(Trigger.new , Trigger.oldMap);
}