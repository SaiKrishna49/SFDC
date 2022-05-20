/**************************************************************************************************
*** Class Name         : DisplayObjectsClass
*** Class Description  : This class is used to invoke lightning componet DisplayObjects.
*** Author             : Krishna
*** Class Created Date : 17-Nov-2021
************************************************************************************************/


public class DisplayObjectsClass{
    public class Wrapper{
        @AuraEnabled   PUBLIC List<string> labels;
        @AuraEnabled  PUBLIC  List<string> APINames;
        @AuraEnabled   PUBLIC List<string> Types;
        @AuraEnabled  PUBLIC List<Sobject> sobjectlist;
    }
    @AuraEnabled
    public static List<string> allObjectsList(){
        List<string> SObjList = new List<string>();
        Map<string,string> labeltoapi=new map<string,string>();
        list<schema.SObjectType> ObjectType = schema.getGlobalDescribe().values();
        for(SObjectType objType : ObjectType){
            String name = objType.getDescribe().getlabel();
            labeltoapi.put(objType.getDescribe().getlabel(),objType.getDescribe().getName());
            SObjList.add(name);
            System.debug( 'Name : ' + name);
            SObjList.sort();
        }
        return SObjList;
    }
    @AuraEnabled
    public static List<String> allFieldsList(String flds){
        Map<string,string> labeltoapi=new map<string,string>();
        list<schema.SObjectType> ObjectType = schema.getGlobalDescribe().values();
        for(SObjectType objType : ObjectType){
            
            labeltoapi.put(objType.getDescribe().getlabel(),objType.getDescribe().getName());
        }
        List<String> fieldList = new List<String>();
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get(labeltoapi.get(flds));
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 
        for(string str: fieldsMap.keySet()){
            fieldList.add(fieldsMap.get(str).getDescribe().getLabel());                
        }
        
        system.debug('fieldList=='+ fieldList);
        return fieldList;      
    }
    
    @AuraEnabled
    public static Wrapper getQuerryAPI(list<string> selectfield, string userObj){
        Map<String,String> fieldLabelToName=new Map<String,String>();
        Wrapper wrapperVariables=new Wrapper();
        wrapperVariables.labels=new List<String>();
        wrapperVariables.APINames=new List<String>();
        wrapperVariables.types=new List<String>();
        Map<string,String> objectLabelToName=new Map<string,String>();
        Map<string,String> LabelToType=new Map<string,String>();
        for( Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            objectLabelToName.put(o.getDescribe().getLabel(),o.getDescribe().getName());
        }
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sobjType = gd.get(objectLabelToName.get(userObj));
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
        for(String fldsss: fieldsMap.keyset()){
            Schema.DescribeFieldResult describeResult1 = fieldsMap.get(fldsss).getDescribe();
            fieldLabelToName.put(describeResult1.getLabel(), describeResult1.getName());
            LabelToType.put(describeResult1.getLabel(),describeResult1.getType()+'');
        }
        for(string str: selectfield){
            System.debug(fieldLabelToName.get(str));
            wrapperVariables.APINames.add(fieldLabelToName.get(str));
            wrapperVariables.labels.add(str);
            wrapperVariables.types.add(LabelToType.get(str));
            
        }
        System.debug(wrapperVariables.APINames);
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
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*//------------Accessing parent field values in child to parent dynamic query----
    //Below is static method which can be used to fetch field values.
    //You need to pass sObject and fieldAPIName to get field value
    public static string ExtractFieldValues(sObject sb, string fieldAPIName){
        string fvalue='';
        if(fieldAPIName.contains('.')){
            List<string> splitedFields = fieldAPIName.split('\\.');
            try{
                for(integer i=0;i<splitedFields.size()-1;i++){
                    sb=sb.getSobject(splitedFields[i]);   
                }
                fvalue = string.valueof(sb.get(splitedFields[splitedFields.size()-1]));
            }catch(exception ex){
                system.debug('******exception while fetching fieldValues as relationship '+fieldAPIName+'  value is blank.'+ex.getmessage()); 
                fvalue='';
            }
            
        }else if(sb.get(fieldAPIName)!=null){
            fvalue = string.valueOf(sb.get(fieldAPIName));
        }
        return fvalue;
    }
    
    List<string> fieldAPINamesList = new List<string>{'Id','Opportunity.Name','Opportunity.Partner__r.Name','Product2.Name'};
        string qString ='Select '+string.join(fieldAPINamesList,',')+ ' from OpportunityLineItem where id=\'00k90000002z4ml\'';
    system.debug('****qString:'+qString);
    sobject sb = database.query(qString);
    //syntax to get OpportunityLineItem Id  value from sObject
    string OpportunityLineItemId = string.valueof(sb.get('Id'));
    system.debug('******OpportunityLineItemId:'+OpportunityLineItemId);
    //syntax to get Opportunity.Name field value from sObject
    string OpportunityName = string.valueof(sb.getSobject('Opportunity').get('Name'));
    system.debug('******OpportunityName:'+OpportunityName);
    //syntax to get Opportunity.Partner__r.Name field value from sObject
    //If partner field in opportunity is blank then you will get null pointer exception
    string partnerName = string.valueof(sb.getSobject('Opportunity').getSObject('Partner__r').get('Name'));
    system.debug('******partnerName:'+partnerName);
    
    //Note: While accessing the parent record details in child to parent query, you will get null pointer exception if parent is blank in child record.
    
    //Below is sample code to get field values by using utility method defined above
    for(string fieldName : fieldAPINamesList){
        string fieldvalue = ExtractFieldValues(sb,fieldName);
        system.debug('******fieldvalue using utility method:'+fieldvalue);
    }
}*/















   /* @AuraEnabled
    public static list<String> getQuerryAPI(list<string> selectfield, string userObj){
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get(userObj); 
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 
        List<string> queryValueList = new List<String>();
        for(string str: fieldsMap.keySet()){
            if(selectfield.contains(fieldsMap.get(str).getDescribe().getLabel())){
                queryValueList.add(str);                     
            }   
        } 
        system.debug(queryValueList);
        return queryValueList;
    }*/





    /*
    @AuraEnabled
       public static list<Sobject> sltoptions(list<string> selectfield, string userObj){
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get(userObj); 
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 
           string QueryString = ' ';
        for(string str: fieldsMap.keySet()){
            if(selectfield.contains(fieldsMap.get(str).getDescribe().getLabel())){
           //     if(str != 'id'){
                    system.debug('str+'+ str);
               QueryString +=  str + ','  ;
             //   }
                     
            }   
        }
           
    String Query = 'SELECT' + QueryString +'from' + userObj ;
           system.debug('=Query=='+ Query);
  		system.debug('QueryString=='+ QueryString);
         list<Sobject> Objectlist = Database.query(Query) ;
           system.debug('Objectlist='+Objectlist);
           return Objectlist;
    }*/