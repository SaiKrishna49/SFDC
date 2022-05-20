public class EventDeleteBatchSchedule IMPLEMENTS Schedulable {
    public static void execute(schedulablecontext sc){
        EventDeleteBatchClass EveDel = new EventDeleteBatchClass();
        Database.executeBatch(EveDel);
    } 

}