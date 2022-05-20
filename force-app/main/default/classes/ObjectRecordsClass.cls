public class ObjectRecordsClass {
   
    @AuraEnabled
    public static List<String> getObjectNames(){
        list<String> ObjectNames=new List<String>();
        for( Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            ObjectNames.add(o.getDescribe().getLabel());
        }
        ObjectNames.sort();
        return ObjectNames;
    }
    @AuraEnabled
    public static List<String> getFields(String selectedObject){
        List<String> fieldList = new List<String>();
        Map<string,String> LabelToName=new Map<string,String>();
        for( Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            LabelToName.put(o.getDescribe().getLabel(),o.getDescribe().getName());
        }
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(LabelToName.get(selectedObject));
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
        for(string str: fieldsMap.keySet()){
            fieldList.add(fieldsMap.get(str).getDescribe().getLabel());
        }
        return fieldList;
    }
    @AuraEnabled
    public static Wrapper getQuerryAPI(list<string> selectfield, string userObj){
        Map<String,String> fieldLabelToName=new Map<String,String>();
        Wrapper wrapperVariables=new Wrapper();
        wrapperVariables.labels=new List<String>();
        wrapperVariables.Names=new List<String>();
        wrapperVariables.Types=new List<String>();
        Map<string,String> objectLabelToName=new Map<string,String>();
        Map<string,String> LabelToType=new Map<string,String>();
        for( Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            objectLabelToName.put(o.getDescribe().getLabel(),o.getDescribe().getName());
        }
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(objectLabelToName.get(userObj));
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
        string QueryString = 'SELECT Id';
        for(String fldsss: fieldsMap.keyset()){
            Schema.DescribeFieldResult describeResult1 = fieldsMap.get(fldsss).getDescribe();
            fieldLabelToName.put(describeResult1.getLabel(), describeResult1.getName());
            LabelToType.put(describeResult1.getLabel(),describeResult1.getType()+'');
            if(selectfield.contains(fieldsMap.get(fldsss).getDescribe().getLabel())){
                if(fldsss != 'id'){
                    system.debug('str+'+ fldsss);
                    QueryString +=( ', '+ fldsss);
                }
                
            }
        }
        QueryString += ' from ' + objectLabelToName.get(userObj) ;
        system.debug('QueryString=='+ QueryString);
        wrapperVariables.sobjectlist= Database.query(QueryString) ;
        for(string str: selectfield){
            System.debug(fieldLabelToName.get(str));
            wrapperVariables.Names.add(fieldLabelToName.get(str));
            wrapperVariables.labels.add(str);
            wrapperVariables.Types.add(LabelToType.get(str));
            
        }
        return wrapperVariables;
    }
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
@AuraEnabled(cacheable=true)
public static List<String> getFieldSets(String selectedObject){
    List<String> fieldSets=new List<String>();
    Map<string,String> LabelToName=new Map<string,String>();
        for( Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            LabelToName.put(o.getDescribe().getLabel(),o.getDescribe().getName());
        }
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(LabelToName.get(selectedObject));
        for(Schema.FieldSet fSets:gd.get(LabelToName.get(selectedObject)).getDescribe().fieldSets.getMap().values()){
fieldSets.add(fSets.getLabel());
        }

return fieldSets;
}
@AuraEnabled(cacheable=true)
public static Wrapper getFieldSetFields(String objects,String fieldsets){
    System.debug(objects+fieldsets);
        wrapper wp=new wrapper();
        List<String> fields=new List<String>();
        Map<String,String> labelToNameSets=new Map<String,String>();
        Map<string,String> LabelToName=new Map<string,String>();
        for( Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            LabelToName.put(o.getDescribe().getLabel(),o.getDescribe().getName());
        }
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(LabelToName.get(objects));
        for(Schema.FieldSet fSets:gd.get(LabelToName.get(objects)).getDescribe().fieldSets.getMap().values()){
labelToNameSets.put(fSets.getLabel(),fSets.getName());
        }
        
    Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
    Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(LabelToName.get(objects));
    Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
System.debug(DescribeSObjectResultObj.FieldSets.getMap().get(labelToNameSets.get(fieldsets)));
Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(labelToNameSets.get(fieldsets));
for(Schema.FieldSetMember s:fieldSetObj.getFields()){
    fields.add(s.getLabel());
}
System.debug('ijijf'+fields);
return getQuerryAPI(fields,objects);

}
    
    
   
    public class Wrapper{
        @AuraEnabled public List<String> labels;
        @AuraEnabled public List<String> Names;
        @AuraEnabled public List<String> Types;
        @AuraEnabled public List<Sobject> sobjectlist;
    }
}




/* public class wrapperChildObjClass{
     @AuraEnabled
        public Id recordId;        
        
        public wrapperChildObjClass(Id recordId){            
            this.recordId = recordId;                
        }
    }*/
   /*  @AuraEnabled
    public static List<wrapperChildObjClass> childObjWrapMethod(){
      List<wrapperChildObjClass> wrapObj = new List<wrapperChildObjClass>();   
       List<childObjTrigger__c> childObjList = [Select Id, Name From childObjTrigger__c limit 1];         
        for(childObjTrigger__c childObjWrp: childObjList){
            wrapObj.add(new wrapperChildObjClass(childObjWrp.Id));
        }     
        return wrapObj;
     }   */