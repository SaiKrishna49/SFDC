public class QueueOppDelete Implements Queueable{
    public static void execute(Queueablecontext qc){
        list<opportunity> OppList = [SELECT id,StageName FROM opportunity WHERE StageName='Closed Won'];
        system.debug('OppList.size()='+ OppList.size());
    }

}