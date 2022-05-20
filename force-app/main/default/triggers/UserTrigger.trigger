trigger UserTrigger on User (after insert) {
    UserTriggerHandler.assignPermission(Trigger.new);
UpdateMngerNmeFrmUser.updateManager(Trigger.new, Trigger.oldmap);
}