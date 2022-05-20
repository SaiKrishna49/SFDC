public class CaseEscalationController {  
      
    @AuraEnabled( cacheable=true )      
    public static Case fetchCase( String strRecordId )  {   
          
        system.debug( 'Id is ' + strRecordId );  
        List < Case > listCases = [ SELECT Id FROM Case WHERE ParentId =: strRecordId LIMIT 1 ];  
          
        if( listCases.size() > 0 )  
            return listCases.get( 0 );  
        else  
            return null;  
          
    }  
  
}