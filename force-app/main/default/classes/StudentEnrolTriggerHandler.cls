/**************************************************************************************************
*** Class Name             : StudentEnrolTriggerHandler
*** Class Description      : Scenario:
                            1.	When ever the Student Enrolments are created/deleted the Number of Enrolments field on Activity (Parent object) should be updated to reflect the count of existing student enrolments.
                            2.	A new Student Enrolment cannot be created before two days of Activity Start Date. 
                            		a.	For example, Activity Start Date is 20th March, the new enrolments are only allowed to be created before 18th March.
                            3.	The Total number of Student Enrolments on an Activity should not exceed the “Max number of Enrolments allowed” on Activity. 
                            		a.	For Example, if the Max number of enrolments is 5, the system should not allow the user to create 6th Student Enrolment.
                            4.	The check box “Participated in Activity” on Student Enrolment object should not be updated once the “End Date” on activity is past. 
                            		a.	For Example – The Activity End Date is 20th March, the system should not allow the field to be updated.
                            5.	The field on Activity “Number of Students Participated” should be updated with the count of “Student Enrolments” with “Participated in Activity” checked.

*** Author                 : Krishna
*** Class Created Date     : 09-Nov-2021
**************************************************************************************************/

public class StudentEnrolTriggerHandler {
    public static void studentEnrolmentsSizeAndToAddErrorMsg(list<Student_Enrolment__c> StudentEnrolments){
        list<Activity__c> activityList = new list<Activity__c>();
        set<Id> studentEnrolementIdSet = new set<Id>();
        for(Student_Enrolment__c Enrolements:StudentEnrolments){
            studentEnrolementIdSet.add(Enrolements.Activity__c);
        }
        for(Activity__c actREc:[SELECT id,name,Number_of_Enrolments__c,start_date__c,CreatedDate,end_date__c,Max_number_of_Enrolments_allowed__c,
                             (SELECT id,Student__c,Activity__c,Participated_in_Activity__c FROM Student_Enrolments__r ) 
                             FROM Activity__c  WHERE id IN:studentEnrolementIdSet]){
                                 actREc.Number_of_Enrolments__c=actREc.Student_Enrolments__r.size();
                                 if(actREc.Number_of_Enrolments__c > actREc.Max_number_of_Enrolments_allowed__c){
                                     for(Student_Enrolment__c StudEnrolements:StudentEnrolments){ 
                                         StudEnrolements.addError('You cannot create a record, Max number of Enrolments allowed size is reached');
                                     }   
                                 }
                                 activityList.add(actREc);  
                             }
        if(activityList.size() > 0){
            UPDATE activityList;
        }
    }
    public static void toUpdateParticipatedStudents(list<Student_Enrolment__c> Studentnrolments){
        list<Activity__c> activityList=new list<Activity__c>();
        set<Id> studentEnrolementIdSet=new set<Id>();
        for(Student_Enrolment__c studentEnrolement:Studentnrolments){
            if(studentEnrolement.Participated_in_Activity__c==true){
                studentEnrolementIdSet.add(studentEnrolement.Activity__c);
            } 
        }
        for(Activity__c actRec:[SELECT Number_of_students_Participated__c,
                                       (SELECT id,Participated_in_Activity__c FROM Student_Enrolments__r WHERE Participated_in_Activity__c=true )
                                       FROM Activity__c WHERE id IN:studentEnrolementIdSet]){
            actRec.Number_of_students_Participated__c=actRec.Student_Enrolments__r.size();
            activityList.add(actRec);
        }
        if(activityList.size() > 0){
             UPDATE activityList;
        }
    }
    Public static void toUpdateEnrolmentsStartDateAndEndDate(list<Student_Enrolment__c> StudentEnrolments){
        set<Id> studentEnrolementIdSet=new set<id>();
        for(Student_Enrolment__c enrolments:StudentEnrolments){
            studentEnrolementIdSet.add(enrolments.Activity__c);
        }
        list<Activity__c> actvty= [SELECT id, start_date__c,CreatedDate,end_date__c,(SELECT id FROM Student_Enrolments__r)
                                   FROM Activity__c WHERE id IN:studentEnrolementIdSet];
        for(Activity__c actRec:actvty){
            if(System.today().daysBetween(actRec.Start_Date__c) <= 2){
                for(Student_Enrolment__c studEnrlRec:StudentEnrolments){
                    studEnrlRec.addError('you cannot create a record before two days of activity start date ');
                }
                
            }
        }
        for(Activity__c actRec:actvty){
          if(actRec.End_Date__c.daysBetween(System.today()) >= 1){
                for(Student_Enrolment__c studEnrlRec:StudentEnrolments){
                    studEnrlRec.Participated_in_Activity__c.addError('End date is over you cannot update the record');   
                }
            }
        } 
    }
}















/* Public static void ToUpdateEnrolmentsStartDateandEndDateOne(map<id,Student_Enrolment__c>oldmap,map<id,Student_Enrolment__c>newmap){
        list<Activity__c>activity= [select id, Start_Date__c,CreatedDate,End_Date__c,(select id from Student_Enrolments__r)
                                    from Activity__c];
        DateTime DT1 = System.now();
        DT1 = DT1.addDays(+1);
        for(id key:oldmap.keySet()){
            Student_Enrolment__c ol=oldmap.get(key);
            Student_Enrolment__c nw=newmap.get(key);
            for(Activity__c ac:activity){
                if(ac.End_Date__c>DT1){
                    ol.Participated_in_Activity__c.addError('End date is over you cannot update the record');
                }
            }
        }
        
    }*/