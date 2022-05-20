/**************************************************************************************************
*** Class Name             : FoodRecipieAPIClass_TestclassController
*** Class Description      : This Test class controller for  FoodRecipieAPIClass_TEST.
*** Author                 : Krishna
*** Class Created Date     : 11-Nov-2021
**************************************************************************************************/

@isTest
public class FoodRecipieAPIClass_TestClassController {
    @isTest static void Controllertest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FoodRecipieAPIClass_TestClass());
        FoodRecipieAPIClass.getFoodReceipe();
        FoodRecipieAPIClass.getFoodReceipebyID('716429');
        FoodRecipieAPIClass.getFoodReceipeByIngredients('sugar,banana');
        Test.stopTest();
    }
    
}