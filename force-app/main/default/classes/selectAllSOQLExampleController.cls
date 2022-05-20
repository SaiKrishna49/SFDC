public class selectAllSOQLExampleController {
    public List<Account> accList{get;set;}
    public String query{get;set;}
    public selectAllSOQLExampleController(){
    }
    public PageReference fetch(){
        String SobjectApiName = 'Account';
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' Limit 5';
 
        accList = Database.query(query);
 
        return null;
    }
}