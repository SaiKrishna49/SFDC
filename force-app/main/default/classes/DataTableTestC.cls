public class DataTableTestC {
    
    @InvocableVariable(required=true)
     public String varType1;
    
    @AuraEnabled
    public static List<contact> getOpportunities()
    {
        List<contact> oppList=new List<contact>();
        
        oppList=[select name,Phone from contact
                 ];
        
        return oppList;
    }
    
}