@isTest
private class AccRelatedConCTest
{
    @isTest
    static void TestfetchAcc()
    {
        list<account> result=AccRelatedConC.fetchAcc();
        System.assertNotEquals(null, result);
    }
    @isTest
    static void TestfetchCon()
    {
        String recordId = '0035g000004k5zoAAA';
        list<contact> result1=AccRelatedConC.fetchCon(recordId);
        System.assertNotEquals(null, result1);
    }
}