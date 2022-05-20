/**************************************************************************************************
*** Class Name             : StudentEnrollementsTriggerHandler
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

public class StudentEnrolmentsTriggerHandler {
    public static void countOfStudentEnrolmentsInUpdate(list<Student_Enrolment__c> newStdEnrolmentList , map<id,Student_Enrolment__c> oldStdEnrolmentMap){
        set<id> actIdSet = new set<id>();
        list<Activity__c> activityListToUpdate = new list<Activity__c>();
        for(Student_Enrolment__c StdEnrolRec : newStdEnrolmentList){
            Student_Enrolment__c  oldStdEnrlmnt = (Student_Enrolment__c)Trigger.oldMap.get(oldStdEnrolmentMap.values().Id); 
            if(StdEnrolRec.Activity__r.id != oldStdEnrlmnt.Activity__r.id){
                actIdSet.add(StdEnrolRec.Activity__r.id);
                actIdSet.add(oldStdEnrlmnt.Activity__r.id);
            }
            system.debug('actIdSet In uPdate='+ actIdSet);
        }         
        if(actIdSet != null){
            for(Activity__c actRec : [SELECT id,Number_of_Enrolments__c,Number_of_students_Participated__c,
                                      (SELECT id,Activity__c,Participated_in_Activity__c,Student__c FROM Student_Enrolments__r) 
                                      FROM Activity__c WHERE id IN:actIdSet]){
                                          system.debug('actRec in update='+actRec);
                                          if(actRec != null){
                                              actRec.Number_of_Enrolments__c =  actRec.Student_Enrolments__r.size();
                                              system.debug('actRec.Number_of_Enrolments__c in update=='+ actRec.Number_of_Enrolments__c);
                                            
                                             
                                              activityListToUpdate.add(actRec);
                                              
                                          }
          for(Activity__c actRecStdParticp :[SELECT id,Number_of_Enrolments__c,Number_of_students_Participated__c,
                                      (SELECT id,Activity__c,Participated_in_Activity__c,Student__c FROM Student_Enrolments__r WHERE Participated_in_Activity__c = TRUE) 
                                             FROM Activity__c WHERE id IN:actIdSet] ){
                                                 if(actRecStdParticp != Null){
                                                   actRecStdParticp.Number_of_students_Participated__c = actRecStdParticp.Student_Enrolments__r.size();  
                                                 }
                                             }
                                        
                                          
                                      }
            
            if(activityListToUpdate.size() >0){
                UPDATE activityListToUpdate;
            }
        }
    }
    public static void countOfStudentEnrolmentsInInsert(list<Student_Enrolment__c> newStudentEnrollList){
        set<id> actIdSet = new set<id>();
        list<Activity__c> activityListToUpdate = new list<Activity__c>();
        for(Student_Enrolment__c StdEnrolRec : newStudentEnrollList){
           
          system.debug('StdEnrolRec.Activity__c in insert method='+ StdEnrolRec.Activity__c);
                actIdSet.add(StdEnrolRec.Activity__c);
            system.debug('actIdSet in insert='+actIdSet);
                
        }
        if(actIdSet != null){
            for(Activity__c actRec : [SELECT id,Number_of_Enrolments__c,Number_of_students_Participated__c,
                                      (SELECT id,Activity__c,Participated_in_Activity__c,Student__c FROM Student_Enrolments__r) 
                                      FROM Activity__c WHERE id IN:actIdSet]){
                                          if(actRec != null){
                                              actRec.Number_of_Enrolments__c =  actRec.Student_Enrolments__r.size();
                                              system.debug('actRec.Number_of_Enrolments__c=='+ actRec.Number_of_Enrolments__c);
                                            
                                              activityListToUpdate.add(actRec);
                                      }
                                      }
            if(activityListToUpdate.size() >0){
                UPDATE activityListToUpdate;
            }
        }
    }
    public static void getCountOfStudentsParticipatedInsert(list<Student_Enrolment__c> newStudentEnrollListToStdPart){
         set<id> actIdSet = new set<id>();
        list<Activity__c> activityListToUpdate = new list<Activity__c>();
        for(Student_Enrolment__c StdEnrolRec : newStudentEnrollListToStdPart){
            if(StdEnrolRec.Participated_in_Activity__c == TRUE){
                actIdSet.add(StdEnrolRec.Activity__c);
                system.debug('actIdSet='+actIdSet);
            }
                
                
        }
        if(actIdSet != null){
            for(Activity__c actRec : [SELECT id,Number_of_Enrolments__c,Number_of_students_Participated__c,
                                      (SELECT id,Activity__c,Participated_in_Activity__c,Student__c FROM Student_Enrolments__r WHERE Participated_in_Activity__c = TRUE) 
                                      FROM Activity__c WHERE id IN:actIdSet]){
                                          if(actRec != null){
                                             actRec.Number_of_students_Participated__c = actRec.Student_Enrolments__r.size();
                                             /* if(actRec.Max_number_of_Enrolments_allowed__c < actRec.Number_of_Enrolments__c){
                                                 actRec.adderror('limit exceded');
                                              }*/
                                              activityListToUpdate.add(actRec);
                                      }
                                      }
            if(activityListToUpdate.size() >0){
                UPDATE activityListToUpdate;
            }
        }
    }
    public static void get(){}
}