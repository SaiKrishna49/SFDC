public class EmployeeBdayEmailScheduleClass implements Schedulable {
    public void execute (SchedulableContext sc){
        EmployeeBatchClass EBC = new EmployeeBatchClass();
        Database.executeBatch(EBC);
    }
}