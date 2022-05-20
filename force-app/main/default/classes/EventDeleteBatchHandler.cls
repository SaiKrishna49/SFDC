public class EventDeleteBatchHandler {
    public static void DeleteEventBatch(List<Event__c> eventDeleteList){
        DELETE eventDeleteList;
        //To purge the records i.e perminantly delete the records use Database.emptyRecycleBin(list to delete);
        Database.emptyRecycleBin(eventDeleteList);
    }
}