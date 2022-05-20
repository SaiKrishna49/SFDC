/**************************************************************************************************
*** interface Name             : ITriggerHandler
*** interface Description      : This interface is used to invoke TriggerDispatcher class.
*** Author                     : Krishna
*** interface Created Date     : 15-Nov-2021.
****************************************************************/

/*
@Author : Sai Krishna
@CreatedDate : 15th Nov 2021
@Description : Trigger Handler Interface
*/
public interface ITriggerHandler{

    void beforeInsert(List<sObject> newList);
     
    
    void afterInsert(List<sObject> newList, Map<Id, sObject> newMap);
     
    
    void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap);
     
  
    void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap);
     
            
    void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap);
     
  
    void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap);
     
   
    void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap);
     
    
    Boolean isDisabled();
}