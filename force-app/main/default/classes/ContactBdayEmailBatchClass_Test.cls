/**************************************************************************************************
*** Class Name             : ContactBdayEmailBatchClass_Test
*** Class Description      : This Test class is written for ContactBdayEmailBatchClass.
*** Author                 : Krishna
*** Class Created Date     : 25-Oct-2021

**************************************************************************************************/

@istest
public class ContactBdayEmailBatchClass_Test 
{
    @istest
    public static void conBdayTestMethod()
    {
        List<Contact> conList=new List<Contact>();
            Contact testCon=new Contact();
            testCon.LastName='Test';
            testCon.Email='tirumalasettisaikrishna@gmail.com';
            testCon.Birthdate= Date.parse('10/25/2000');
            conList.add(testCon);
         Insert(conList);
        contact con=[SELECT LASTNAME,birthdate FROM Contact ];
        System.assertEquals(Date.parse('10/25/2000'), con.Birthdate);
       Test.startTest();
      ContactBdayEmailBatchClass BatchClass = new ContactBdayEmailBatchClass();
        Database.QueryLocator QueryLoc = BatchClass.start(null);
        BatchClass.execute(null,conList);
        BatchClass.Finish(null);
     Test.stopTest();
        
    }
}




/*
 * 
 * 
 * for(Schema.SobjectField strFld: opportunity.SobjectType.getDescribe().fields.getMap().Values()){
if(strFld.getDescribe().getType() == Schema.DisplayType.REFERENCE){
system.debug('==parent object='+strFld.getDescribe().getReferenceTo());
}
}

Schema.DescribeSObjectResult R = opportunity.SObjectType.getDescribe();
for (Schema.ChildRelationship cr: R.getChildRelationships()) {
system.debug('====child object==='+cr.getChildSObject());
}
system.debug(opportunity.SobjectType.getDescribe().fields.getMap().Values().size()+R.getChildRelationships().size());
***/