public class resourceAllocationTriggerHandler {
	public static void createRecord(List<Resource_Allocation__c> newList){
        set<id> resourceAllocationIdSet = new set<id>();
        list<utilization__c> utilizationList = new  list<utilization__c>();
        for(Resource_Allocation__c rec : newList){
            resourceAllocationIdSet.add(rec.id);
        }
        if(resourceAllocationIdSet.size() > 0){
            for(Resource_Allocation__c resAllocRec : [SELECT id,name,Resource__c,start_date__c,end_date__c,Avg_Weekly_Hours__c FROM Resource_Allocation__c WHERE ID IN :resourceAllocationIdSet]){
                utilization__c util = new utilization__c();
                 integer noofmonths = resAllocRec.end_date__c.monthsBetween(resAllocRec.start_date__c);
        integer startmonth=resAllocRec.Start_Date__c.month();
        integer endmonth =resAllocRec.End_Date__c.month();
        Integer noOfDays = resAllocRec.Start_Date__c.daysBetween(resAllocRec.End_Date__c);
        System.debug('no of months--->'+noofmonths);
        System.debug('start date---months=='+resAllocRec.Start_Date__c.month());
        System.debug('End date---months=='+resAllocRec.end_date__c.month());
        system.debug('days between in a month=='+noOfDays);
                for(integer i=startmonth;i<=endmonth;i++){
                     util.Month__c = String.valueOf(i);
                      util.Name = resAllocRec.Resource__c+ String.valueOf(i);
               
                util.Monthly_Hou__c = resAllocRec.Avg_Weekly_Hours__c * 4;
                util.Resource__c = resAllocRec.Resource__c;
              
                utilizationList.add(util);
                }
            }
        }
        if(utilizationList.size() > 0){
            UPSERT utilizationList;
        }
        
    }
}