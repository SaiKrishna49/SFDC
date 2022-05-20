/**************************************************************************************************
*** Class Name             : FoodRecipieAPIClass
*** Class Description      : This class will be invoked when the data is given for the recipie and the ingridiants, 
								the generated Json is converted to CSV file and adding to record as an attachment.
*** Author                 : Krishna
*** Class Created Date     : 12-JAN-2022
**************************************************************************************************/

public class FoodRecipieAPIClass {
    @TestVisible 
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    @TestVisible 
    private static final String API_KEY = 'f8ad8a32c97c4993a81dfb7515495556';
    public static void getFoodReceipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse res =  http.send(request);
        System.debug('response Code '+res.getStatusCode());
        if(res.getStatusCode() == 200)
        {
            System.debug('response ='+res.getBody());
        }
    }
    public static void getFoodReceipebyID(String receipeId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse res =  http.send(request);
        System.debug('response Code== '+res.getStatusCode());
        if(res.getStatusCode() == 200)
        {
            System.debug('response '+res.getBody());
        }
    }
    public static void getFoodReceipeByIngredients(String Ingredients){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API+'/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse res =  http.send(request);
        System.debug('response Code== '+res.getStatusCode());
        if(res.getStatusCode() == 200)
        {
            System.debug('response '+res.getBody());
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf(res.getBody());
            attachment.Name = 'csvFileforJASONResponse.csv';
            attachment.ParentId = '0015g000003ShzhAAC';
            insert attachment;
            system.debug('Attachment'+attachment);
        }  
    }
}




/*
 * FoodRecipieAPIClass.getFoodReceipe();
FoodRecipieAPIClass.getFoodReceipebyID('716429');
FoodRecipieAPIClass.getFoodReceipeByIngredients('sugar,banana');
*/