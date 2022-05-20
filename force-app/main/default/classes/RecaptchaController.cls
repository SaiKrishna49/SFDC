public with sharing class RecaptchaController {   
    
    private static String recaptchaSecretKey = '6LdPeU0fAAAAABNMqxU6WeZfIeXu5bCFWqO94D1T';
        
    @AuraEnabled
    public static String insertRecord( SObject record, String recaptchaResponse ) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.google.com/recaptcha/api/siteverify' );
        request.setMethod( 'POST');
        request.setBody( 'secret=' + recaptchaSecretKey + '&response=' + recaptchaResponse );
        HttpResponse response = http.send( request );

        if ( response.getStatusCode() == 200 ) {
            
            System.debug( 'Response Body is ' + response.getBody() );
            Map < String, Object > result = ( Map< String, Object > ) JSON.deserializeUntyped( response.getBody() );

            if ( result.containsKey( 'success' ) && result.get( 'success' ) == true) {

                if ( result.containsKey( 'score' ) ) {
                    
                    String action = ( String )result.get( 'action' );
                    Decimal threshold = .4;
                    Decimal score = ( Decimal )result.get( 'score' );

                    if ( score > threshold ) {
                       
                        insert record;
                        return 'Success - v3';

                    }

                } else {
                    
                    insert record;
                    return 'Success - v2';

                }
                
            } else {

                return 'Invalid Verification';

            }
            
        }
        
        return 'Invalid Verification Request';

    }

}