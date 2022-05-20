public class Notes {
    /*
SOQL query to retrieve all the object Name and API names of Sobject in Salesforce:

Fields:
SELECT QualifiedApiName FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName = 'Account' 

Objects:
SELECT  QualifiedApiName FROM EntityDefinition order by QualifiedApiName 


*/

}