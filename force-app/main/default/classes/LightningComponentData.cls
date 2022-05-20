Public class LightningComponentData {
    @AuraEnabled
    public static List<String> getObjectName()
    {
        system.debug('***************');
        List<String> objects=new List<String>();
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        for(SObjectType sot:gd)
        {
            objects.add(sot.getDescribe().getLabel());
            objects.sort();
        }
        system.debug('objects=='+objects);
        return objects;
        
    }
    
    @AuraEnabled
    public static list<string> getFieldList(string selectedSObject)
    {
        list<string> fieldList = new list<string>();
        map<string,string> labelToName = new map<string,string>();
        for(schema.SObjectType var1 : schema.getGlobalDescribe().values()){
            labelToName.put(var1.getDescribe().getlabel(), var1.getDescribe().getName());
        }
        if(selectedSObject != null)
        {
            Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
            Schema.SObjectType sobjType = gd.get(LabelToName.get(selectedSObject));
            Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();
            map<string,Schema.SObjectField> fList = describeResult.fields.getMap();
            system.debug('fList keys=='+fList.keyset());
            system.debug('fList values=='+fList.values());
            for(string str: fList.keySet())
            {
                fieldList.add(fList.get(str).getDescribe().getLabel());
                // fieldList.put(str, fList.get(str).getDescribe().getName());
                
            }
        }
        system.debug('fieldList=='+fieldList);
        return fieldList;
        
        
    }
    
    @AuraEnabled
    public static ObjectWrapper getSelectOptions(List<string> selectField, String userObj){
        Map<String,String> fieldLabelToName=new Map<String,String>();
        ObjectWrapper wrapperVariables=new ObjectWrapper();
        wrapperVariables.labels=new List<String>();
        wrapperVariables.Names=new List<String>();
        wrapperVariables.Types=new List<String>();
        Map<string,String> objectLabelToName=new Map<string,String>();
        Map<string,String> LabelToType=new Map<string,String>();
        for( Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            objectLabelToName.put(o.getDescribe().getLabel(),o.getDescribe().getName());
            // system.debug('objectLabelToName=='+objectLabelToName);
        }
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(objectLabelToName.get(userObj));
        // system.debug('sobjType=='+sobjType);
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
        // system.debug('fieldsMap=='+fieldsMap);
        for(String fldsss: fieldsMap.keyset()){
            Schema.DescribeFieldResult describeResult1 = fieldsMap.get(fldsss).getDescribe();
            fieldLabelToName.put(describeResult1.getLabel(), describeResult1.getName());
            // system.debug('fieldLabelToName=='+fieldLabelToName);
            LabelToType.put(describeResult1.getLabel(),describeResult1.getType()+'');
            // system.debug('LabelToType=='+LabelToType);
        }
        system.debug('selectField=='+selectField);
        for(string str: selectField){
            System.debug(fieldLabelToName.get(str));
            wrapperVariables.Names.add(fieldLabelToName.get(str));
            wrapperVariables.labels.add(str);
            wrapperVariables.Types.add(LabelToType.get(str));
        }
        System.debug(wrapperVariables.names);
        string QueryString = 'SELECT Id';
        for(string str: fieldsMap.keySet()){
            if(selectfield.contains(fieldsMap.get(str).getDescribe().getLabel())){
                if(str != 'id'){
                    system.debug('str+'+ str);
                    QueryString +=( ', '+ str);
                }
            }
        }
        QueryString += ' from ' + objectLabelToName.get(userObj) ;
        system.debug('QueryString=='+ QueryString);
        wrapperVariables.sobjectlist= Database.query(QueryString) ;
        return wrapperVariables;
        
    }
    public class ObjectWrapper{
        @AuraEnabled public List<String> labels;
        @AuraEnabled public List<String> Names;
        @AuraEnabled public List<String> Types;
        @AuraEnabled public List<Sobject> sobjectlist;
    }
}