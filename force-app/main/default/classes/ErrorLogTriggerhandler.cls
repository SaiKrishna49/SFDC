public class ErrorLogTriggerhandler {
    public static void getdetails(list<string> ProcessName, list<string> LogDetails, list<Datetime> LogDateTime){
        list<Error_Log__c> ErrorLogList = new list<Error_Log__c>();
        for(integer i=1;i <=LogDetails.size(); i++){
            Error_Log__c  Errorlog = new Error_Log__c();
            Errorlog.Process_Name__c = ProcessName[i];
            Errorlog.Log_Details__c = LogDetails[i];
            Errorlog.Log_Date_Time__c = LogDateTime[i];
            ErrorLogList.add(Errorlog);
        }
        INSERT ErrorLogList;
    }
}