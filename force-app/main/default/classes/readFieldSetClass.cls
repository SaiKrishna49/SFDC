public class readFieldSetClass {
    public static List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName)
{
    Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
    Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
    Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();

    //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));

    Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);

    //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
    //system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
    return fieldSetObj.getFields(); 
}  

}   


/*
 * 
 * List<Schema.FieldSetMember> fieldSetMemberList =  readFieldSetClass.readFieldSet('AccSet1','Account');
for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList)
{
    system.debug('API Name ====>' + fieldSetMemberObj.getFieldPath()); //api name
    system.debug('Label ====>' + fieldSetMemberObj.getLabel());
    system.debug('Required ====>' + fieldSetMemberObj.getRequired());
    system.debug('DbRequired ====>' + fieldSetMemberObj.getDbRequired());
    system.debug('Type ====>' + fieldSetMemberObj.getType());   //type - STRING,PICKLIST
}
system.debug('fieldSetMemberList=='+fieldSetMemberList);

*/