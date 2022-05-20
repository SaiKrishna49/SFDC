/**************************************************************************************************
*** Class Name             : OpportunityTriggerHandler
*** Class Description      : This class invokes when an opportunity is cloned and the fileds which are stored in field set are assigned to null values.
*** Author                 : Krishna
*** Class Created Date     : 24-Nov-2021.
****************************************************************/
public class OpportunityTriggerHandler IMPLEMENTS ITriggerHandler{
    public static Boolean TriggerDisabled= false;
    public Boolean isDisabled(){
        RETURN TriggerDisabled;
    }
    public static void beforeInsert( list<Sobject> newList){
        list<opportunity> oppnewList = (List<opportunity>) newList;
        for(Schema.FieldSetMember fields :Schema.SObjectType.opportunity.fieldSets.getMap().get('Clear_Field_values_during_clone').getFields()){
            for (Opportunity oppRec: oppnewList) {
                if (oppRec.isClone()) {
                    oppRec.put(fields.getFieldPath(),NULL);
                }
            }
        }
    }
    public static void beforeUpdate(list<Sobject> newList, map<id,Sobject> newmap, list<Sobject> oldList, map<id,Sobject> oldmap){}
    public static void afterInsert(list<Sobject> newList,map<id,Sobject> newMap){}
    public static void afterUpdate(list<Sobject> newList, map<id,Sobject> newmap, list<Sobject> oldList, map<id,Sobject> oldmap){}
    public static void beforeDelete(list<Sobject> oldList,Map<id,Sobject> oldmap){}
    public static void afterDelete(list<Sobject> OldList, map<id,Sobject> oldMap){}
    public static void afterundelete(list<sobject> oldlist, map<id,Sobject> oldmap){}
    
}

    

















/*   List<Schema.FieldSetMember> schemaset= Schema.SObjectType.opportunity.FieldSets.getMap().get(Clear_Field_values_during_clone).getFields();
        for(string FieldsetApiname: Schema.SobjectType.Opportunity.FieldSets.get)
        // clisttoUpdate: fill this list with the records for which you wanted to clone by using dynamic soql with filed set
        List<opportunity> clisttoUpdate=new List<opportunity>();
        //to store mapped records to insert at the end
      //  List<account> acc=new list<account>();
        
        
        List<opportunity> ListWithData=new List<opportunity>();
        List<opportunity> listForClone=new List<opportunity>();
        
        for(integer i=0;i<ListWithData.size();i++){
            
            system.debug(schemaset[i].getFieldPath()+'YYYYYYYYY');
            system.debug(x.get(schemaset[i].getFieldPath())+'FFFFFFFFFFFFF');
            
            opportunity cloneRec=new opportunity();
            
            for(integer a=0;a<schemaset.size();a++){
                cloneRec.get(schemaset[a].getFieldPath()) =clisttoUpdate[i].get(schemaset[a].getFieldPath());
                    
                    }
            
            listForClone.add(cloneRec);
            
        }
        
        
        insert listForClone;
    }*/