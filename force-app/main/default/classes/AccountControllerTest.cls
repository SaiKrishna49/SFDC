@isTest
private class AccountControllerTest {
   string accountId='0015g00000AlaZkAAJ';
    Account actObj;
      @isTest
    Static void AccountControllerTest(){
        Account actObj;
        actObj = new Account();
        system.assertEquals(null, actObj);
            }
    @isTest
    Static void gatAccountsTest(){
        list<account> Acclist = AccountController.gatAccounts();
        system.assertNotEquals(null, Acclist);
    }
	@isTest
    Static void gatAccountRecordsListTest(){
        list<account> Acclist1 = AccountController.gatAccountRecordsList();
        system.assertNotEquals(null, Acclist1);
    }
   /* @isTest
    Static void retriveAccountDetail(){
        list<account> Acclist2 = AccountController.retriveAccountDetail();
        system.assertEquals(actObj, Acclist2);
    }*/
}