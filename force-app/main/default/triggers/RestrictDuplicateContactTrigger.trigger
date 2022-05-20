trigger RestrictDuplicateContactTrigger on Contact (after insert) {
     RestrictDuplicateContactTriggerHandler.Check(Trigger.New);
}