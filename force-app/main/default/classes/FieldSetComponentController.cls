/*
 * @Created Date:- *********
 * @Author : ***********
 * @Description : Class used for the lightning component which illustrate how to use Field Set in 
 *              : Salesforce Lightning Component
 * @Company : ***********
 * @Name : FieldSetComponentController
 */ 
public class FieldSetComponentController {
    
    /*
     * @Created Date:- *********
     * @Author : ************
     * @Name : getsObjects
     * @ReturnType : List<String>
     * @param : none
     * @Description : List all the Objects that have atlead one fieldSet 
     */ 
  @AuraEnabled(cacheable=true)

public static List<String> getsObjects(){

List<String> sObjectList = new List<String>();

System.debug('Before');

FOR(Schema.SObjectType sObj : Schema.getGlobalDescribe().values()){

// Show only those objects which have atleast one Field Set

Map<String, Schema.FieldSet> FieldSetMap = sObj.getDescribe().fieldSets.getMap();

 System.debug(sObj.getDescribe().getLabel());

if(FieldSetMap!=null && FieldSetMap.keySet().size() > 0){

    System.debug(sObj.getDescribe().getLabel());

sObjectList.add(sObj.getDescribe().getLabel());

}

}

return sObjectList;

}
    /*
     * @Created Date:- *********
     * @Author : ***********
     * @Name : getFieldSet
     * @ReturnType : List<String>
     * @param : String sObjectName
     * @Description : List all the Fiels Sets of a particular Object 
     */ 
   @AuraEnabled(cacheable=true)
    public static List<String> getFieldSet(String sObjectName){
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get(sObjectName);
        List<String> fieldSetList = new List<String>();
        FOR(Schema.FieldSet FS : sObj.getDescribe().fieldSets.getMap().values()){
            fieldSetList.add(/*fs.getName() +'####'+*/fs.getLabel());
        }
        return fieldSetList;
    }
    
    /*
     * @Created Date:- **********
     * @Author : **********
     * @Name : getFieldSetMember
     * @ReturnType : String
     * @param : String objectName , String fieldSetName
     * @Description : List all the Fields that are added into the FielsSet
     */
    @AuraEnabled(cacheable=true) //@future
    public static String getFieldSetMember(String objectName , String fieldSetName){
        
        List<FieldSetMemberWrapperClass> wrapperList = new List<FieldSetMemberWrapperClass>();
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get(objectName);
        
        for(Schema.FieldSetMember fieldMember : sObj.getDescribe().fieldSets.getMap().get(fieldSetName).getFields()){
            FieldSetMemberWrapperClass wrapper = new FieldSetMemberWrapperClass();
            wrapper.isDBRequired = fieldMember.getDbRequired();
            wrapper.isRequired = fieldMember.getRequired();
            wrapper.fieldType = String.valueOf(fieldMember.getType());
            wrapper.fieldLabel = fieldMember.getLabel();
            wrapper.fieldAPIName = fieldMember.getFieldPath();
            if(String.valueOf(fieldMember.getType()) == 'PICKLIST' || 
               				String.valueOf(fieldMember.getType()) == 'MULTIPICKLIST'){
                wrapper.pickListValues = sObj.getDescribe().fields.getMap().get(fieldMember.getFieldPath())
                    									   .getDescribe().getPicklistValues();
            }
            wrapperList.add(wrapper);
        }
        //System.debug('#### wrapperList '+wrapperList);
        
        return JSON.serialize(wrapperList);
    }
    
    /*
     * @Created Date:- *********
     * @Author : **********
     * @Name : doUpsertObjects
     * @ReturnType : String
     * @param : sObject objectData
     * @Description : Upsert the Data into the Database and return the upserted record.
     */
    @AuraEnabled(cacheable=true)
    public static String doUpsertObjects(sObject objectData){
        upsert objectData;
        return JSON.serialize(objectData);
    }
    
    /*
     * @Description : Wrapper class contains the information about all the fields of a FieldSet
     */ 
    public class FieldSetMemberWrapperClass{
        
      @AuraEnabled
        public Boolean isDBRequired 					 { get; set; }
        @AuraEnabled
        public Boolean isRequired 						 { get; set; }
       @AuraEnabled
        public String fieldType 						 { get; set; }
       @AuraEnabled
        public String fieldLabel 						 { get; set; }
        @AuraEnabled
        public String fieldAPIName 					     { get; set; }
        @AuraEnabled
        public List<Schema.PicklistEntry> pickListValues { get; set; }
        
    }
}