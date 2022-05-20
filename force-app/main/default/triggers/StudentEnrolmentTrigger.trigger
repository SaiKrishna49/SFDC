/**************************************************************************************************
*** Class Name             : StudentEnrolmentTrigger
*** Class Description      : This Trigger is used to invoke StudentEnrolTriggerHandler class.
*** Author                 : Krishna
*** Class Created Date     : 09-Nov-2021
**************************************************************************************************/


trigger StudentEnrolmentTrigger on Student_Enrolment__c (after insert,after update ,after delete,after undelete)
{
    if(trigger.isInsert){
        StudentEnrolTriggerHandler.studentEnrolmentsSizeAndToAddErrorMsg(trigger.new);
        
    }
    if(trigger.isDelete|| trigger.isUpdate){
        StudentEnrolTriggerHandler.studentEnrolmentsSizeAndToAddErrorMsg(trigger.old);
         StudentEnrolTriggerHandler.toUpdateParticipatedStudents(trigger.old);
    }
   
    if(trigger.isInsert|| trigger.isUpdate){
        StudentEnrolTriggerHandler.toUpdateParticipatedStudents(trigger.new);
       
    }
    if(trigger.isupdate){
         StudentEnrolTriggerHandler.toUpdateEnrolmentsStartDateAndEndDate(trigger.new);
    }
}

















/*{
    if(trigger.isupdate){
        StudentEnrolmentsTriggerHandler.countOfStudentEnrolmentsInUpdate(Trigger.new , Trigger.oldmap);
  }
    else if(trigger.isdelete){
        StudentEnrolmentsTriggerHandler.countOfStudentEnrolmentsInInsert(Trigger.old);
   }
    else{
        StudentEnrolmentsTriggerHandler.countOfStudentEnrolmentsInInsert(Trigger.new);
       StudentEnrolmentsTriggerHandler.getCountOfStudentsParticipated(Trigger.new);
    }
}*/
 

























/*set<id> setActIds = new set<id>();
    set<id> setSEIds = new Set<Id>();
    if(trigger.isbefore){
        if(trigger.isinsert|| trigger.isupdate){
            for(Student_Enrolment__c SE: trigger.new){
            setSEIds.add(SE.Id);
 
            
        }
    }
    if(trigger.isinsert || trigger.isundelete){
        for(Student_Enrolment__c SE: trigger.new){
            setActIds.add(SE.Activity__c);
           
        }
    }
    if(trigger.isdelete)
    {
        for(Student_Enrolment__c SE: trigger.old){
            setActIds.add(SE.Activity__c);
           // setSEIds.add(SE.Id);
        }        
    }
    if(trigger.isupdate){
        for(Student_Enrolment__c SE: trigger.new){
            setActIds.add(SE.Activity__c);
          //  setSEIds.add(SE.Id);
        }
    }
     /*  list<Activity__c> listAct = [SELECT Number_of_Enrolments__c,No_of_Enrolments__c,Name,(select id from Student_Enrolments__r WHERE ID IN:setActIds )FROM Activity__c WHERE ID IN: setActIds];
  /*  system.debug('listAct=='+ listAct);
    for(Activity__c ACT: listAct){
        ACT.Number_of_Enrolments__c = ACT.Student_Enrolments__r.size();
        system.debug('ACT.Number_of_Enrolments__c=='+ ACT.Number_of_Enrolments__c);
        ACT.Number_of_students_Participated__c = ACT.Student_Enrolments__r.size();
        //if(ACT.start_date__c = )
         /*   system.debug('ACT.Number_of_students_Participated__c =='+ ACT.Number_of_students_Participated__c);
         for(Student_Enrolment__c SE : trigger.new){
            system.debug('before se for loop');
            SE.Participated_in_Activity__c = TRUE;
            system.debug('after se for loop');
             update SE;
        
           
        }*/
       /* list<Student_Enrolment__c> listSE = [SELECT id from Student_Enrolment__c  WHERE ID IN:setSEIds];
        system.debug('listSE=='+ listSE);
        for(Student_Enrolment__c SE : listSE){
            system.debug('before se for loop');
            SE.Participated_in_Activity__c = TRUE;
            system.debug('after se for loop');
        }*/
        // update listSE;*/
        // 
        
   
  /*  }
    update listAct;
    system.debug('Updated listAct=='+ listAct);
    }
    }











    /*Map<id,list<Student_Enrolment__c>> MapActStdEnrl = new map<id,list<Student_Enrolment__c>>();
    set<id> setActIds = new set<id>();
    list<Student_Enrolment__c> stdEnrlList = new list<Student_Enrolment__c>();
    list<Activity__c> ActList = new list<activity__c>();
    
    if(trigger.isInsert || trigger.isupdate){
        system.debug('if(trigger.isInsert || trigger.isupdate)');
        for(Student_Enrolment__c SE : trigger.new){
            system.debug('for(Student_Enrolment__c SE : trigger.new)=='+ trigger.new);
            if(string.isNotBlank(SE.Activity__c)){
                setActIds.add(SE.Activity__c);
                system.debug('setActIds.add(SE.Activity__c);=='+setActIds );
            }
        }
    }
    if(trigger.isUpdate || trigger.isdelete){
        system.debug('if(trigger.isUpdate || trigger.isdelete)');
        for(Student_Enrolment__c SE : trigger.old){
            system.debug('trigger.old value=='+ trigger.old);
            setActIds.add(SE.Activity__c);
            system.debug('setActIds.add(SE.Activity__c);=='+ setActIds);
        }
    }
    if(setActIds.size()>0){
        system.debug('setActIds.size()=='+ setActIds.size());
        stdEnrlList = [SELECT id,Activity__c FROM Student_Enrolment__c WHERE ID IN: setActIds ];
        system.debug('stdEnrlList=='+ stdEnrlList);
        for(Student_Enrolment__c SE : stdEnrlList){
            if(!MapActStdEnrl.containsKey(SE.Activity__c)){
                MapActStdEnrl.put(SE.Activity__c, new list<Student_Enrolment__c>());
                system.debug('MapActStdEnrl=='+ MapActStdEnrl);
            }
            MapActStdEnrl.get(SE.Activity__c).add(SE);
            system.debug('MapActStdEnrl get=='+ MapActStdEnrl);
        }
        ActList = [SELECT Number_of_Enrolments__c,No_of_Enrolments__c,Name FROM Activity__c WHERE ID IN: setActIds];
        system.debug('ActList=='+ ActList);
        for(Activity__c AC : ActList){
            list<Student_Enrolment__c> SEList = new list<Student_Enrolment__c>();
            SEList=MapActStdEnrl.get(AC.Id);
            system.debug('ActList=in act for loop=='+ SEList);
            system.debug('SEList.size()=='+ SEList.size());
            AC.Number_of_Enrolments__c = SEList.size();
            system.debug('AC.Number_of_Enrolments__c=='+ AC.Number_of_Enrolments__c);
        }
        update ActList;
        system.debug('ActList updated=='+ ActList);
    }*/