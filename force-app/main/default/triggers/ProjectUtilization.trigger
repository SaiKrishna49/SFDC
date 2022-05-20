trigger ProjectUtilization on Resource_Allocation__c (after insert,after update){
    
    list<Utilization__c>UtilizationList=new list<Utilization__c>();
    set<id>ResourceIds=new set<id>();
    system.debug('A:trigger.new =='+trigger.new);
    for(Resource_Allocation__c RA:trigger.new){
        ResourceIds.add(RA.Resource__c);
    }
    system.debug('ResourceIds=='+ResourceIds);
    map<id,Resource__c> AccountContactMap = new map<id,Resource__c>([Select Id, Name, (Select Id, Name, month__c,Monthly_Hou__c from Utilizations__r),
                                                                     (Select Id, Name, Start_Date__c,End_Date__c,Avg_Weekly_Hours__c from Resource_Allocations__r)
                                                                     from Resource__c where Id IN : ResourceIds]);
    system.debug('AccountContactMap=='+ AccountContactMap);
    System.debug('trigger.new for RA1=='+ trigger.new); 
    for(Resource_Allocation__c RA1:trigger.new){
        system.debug('RA1=='+ RA1);
        integer sum=0;
        sum=sum+RA1.Start_Date__c.daysBetween(RA1.End_Date__c);
        integer sum1=0;
        sum1=sum1+sum/7;
        Decimal sum2=0;
        sum2=sum2+RA1.Avg_Weekly_Hours__c;
        Resource__c rc=AccountContactMap.get(RA1.Resource__c);
        system.debug('rc=='+ rc);
        system.debug('rc!=null=='+rc!=null);
        if(rc!=null){
            system.debug('rc.Utilizations__r=='+ rc.Utilizations__r);
            // list<Utilization__c> utl=new list<utilization__c>(rc.Utilizations__r);
            for(Utilization__c u:rc.Utilizations__r){
                u.Monthly_Hou__c=sum1*sum2;
                u.Name = rc.name+AccountContactMap.values().name;
                UtilizationList.add(u);
            }
        }
        system.debug('UtilizationList before update=='+ UtilizationList);
        UPSERT UtilizationList;
        system.debug('UtilizationList After update=='+ UtilizationList);
    }
}


/*{
/*resourceAllocationTriggerHandler.createRecord(Trigger.new);

//}
map<Resource__c, Resource_Allocation__c> resMap = new  map<Resource__c, Resource_Allocation__c>();
List<utilization__c> utilizationlist = new List<utilization__c>();
for(Resource_Allocation__c itr: Trigger.new)
{
/* if(itr.start_date__c!=Trigger.oldMap.get(itr.ID).start_date__c||itr.end_date__c!=Trigger.oldMap.get(itr.ID).end_date__c || itr.Average_Weekly_Hours__c!=Trigger.oldMap.get(itr.ID).Average_Weekly_Hours__c )
{  
}
//resMap.put( itr.Resource__c.id );
map<ID,list<Resource_Allocation__c>> resorceMap = new map<ID,list<Resource_Allocation__c>>();
//    for(Resource_Allocation__c ress : itr){
//     resorceMap.put(ress.Resource__c, ress);
//  }
integer noofmonths = itr.end_date__c.monthsBetween(itr.start_date__c);
integer startmonth=itr.Start_Date__c.month();
integer endmonth =itr.End_Date__c.month();
Integer noOfDays = itr.Start_Date__c.daysBetween(itr.End_Date__c);
System.debug('no of months--->'+noofmonths);
System.debug('start date---months=='+itr.Start_Date__c.month());
System.debug('End date---months=='+itr.end_date__c.month());
system.debug('days between in a month=='+noOfDays);
integer totalWeeks = noOfDays/7;
system.debug('weeks =='+noOfDays/7);
integer WeeksPerMonth =totalWeeks/4;

system.debug('weeks per month=='+ WeeksPerMonth);
Integer remainder = math.mod(WeeksPerMonth , 4);
system.debug('remainder=='+remainder);
for(integer i=startmonth;i<=endmonth;i++)
{
system.debug('String.valueOf(i)=='+String.valueOf(i));
utilization__c obj = new utilization__c();
/*   
if(i == 1){
obj.month__c='January';
} else if(i == 2){
obj.month__c='Feburary';
}else if(i == 3){
obj.month__c='March';
}else if(i == 4){
obj.month__c='April';
}else if(i == 5){
obj.month__c='May';
}else if(i == 6){
obj.month__c='June';
}else if(i == 7){
obj.month__c='July';
}else if(i == 8){
obj.month__c='August';
}else if(i == 9){
obj.month__c='September';
}else if(i == 10){
obj.month__c='Octomber';
}else if(i == 11){
obj.month__c='November';
}else if(i == 12){
obj.month__c='December';
}
obj.month__c = String.valueOf(i);
//  for(integer j=1 ; j<= WeeksPerMonth;j++){
obj.Monthly_Hou__c=itr.Avg_Weekly_Hours__c * 4;
// }

obj.Resource__c = itr.Resource__c;
obj.Name = itr.Name+'_Month:'+i;
utilizationlist.add(obj);
}
}
upsert utilizationlist;
}

*/

/*

trigger WeeklyHours on Resource_Allocation__c (After insert,After update) {
list<Utilization__c>UtilizationList=new list<Utilization__c>();
set<id>ResourceIds=new set<id>();
for(Resource_Allocation__c RA:trigger.new){
ResourceIds.add(RA.Resource__c);
}
map<id,Resource__c> AccountContactMap = new map<id,Resource__c>([Select Id, Name, (Select Id, Name, month__c,Hours__c from Utilizations__r),
(Select Id, Name, Start_Date__c,End_Date__c,Avg_Weekly_Hours__c from Resource_Allocations__r)
from Resource__c where Id IN : ResourceIds]); for(Resource_Allocation__c RA1:trigger.new){​​
integer sum=0;
sum=sum+RA1.Start_Date__c.daysBetween(RA1.End_Date__c);
integer sum1=0;
sum1=sum1+sum/7;
Decimal sum2=0;
sum2=sum2+RA1.Avg_Weekly_Hours__c;
Resource__c rc=AccountContactMap.get(RA1.Resource__c);
if(rc!=null){
// list<Utilization__c> utl=new list<utilization__c>(rc.Utilizations__r);
for(Utilization__c u:rc.Utilizations__r){
u.Hours__c=sum1*sum2;
UtilizationList.add(u);
}
}
}
Update UtilizationList;
}






*/