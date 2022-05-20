public class ChildCases {
@invocableMethod
    public static void CreateQuote(List<ID> QuoteIds){
        list<case> caselist = new list<case>();
		list<opportunity> OptyList = [SELECT id,Name,number_of_Devices__c FROM opportunity where ID=:QuoteIds];
        for(opportunity op:OptyList){
            if(op.Number_of_Devices__c > 1 && op.StageName == 'Qualification'){
                for(integer i=1; i<=op.Number_of_Devices__c;i++){
                    case c = new case();
                     c.Quote__c = op.Id;
                      caselist.add(c);
                }
            }
        }

    }

}