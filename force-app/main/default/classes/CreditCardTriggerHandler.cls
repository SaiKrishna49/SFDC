/*
* Trigger Handler for before insert event
* CreatedBy : S. Surendra Kumar
* Date: 11/04/2022
* Description: If there is no default credit card for Account, then credit card should be added to account as Default card
*/



public class CreditCardTriggerHandler {
    public static void onBeforeInsert(map<id, Credit_Card__c> lstCrediCards){
            
            /*

List<Credit_Card__c>CreditCardList=[Select id,Card_Holder__c,Default__c from Credit_Card__c where Card_Holder__c=:crdIds AND Default__c=true ];

for(Credit_Card__c cards:lstCrediCards){
if(CreditCardList.size()==0){
cards.Default__c=true;
}else{
cards.Default__c=false;
}

}*/
            
            map<string,Credit_Card__c> accMap =new map<string,Credit_Card__c>([Select id,CardHolder__c,Default__c from Credit_Card__c where CardHolder__c=:lstCrediCards.keyset() AND Default__c=true ]);
            system.debug('accMap.size()=='+accMap.size());
            for(string  cards:lstCrediCards.keyset()){
                if(accMap.size()==0){
                    lstCrediCards.get(cards).Default__c =true;
                }else{
                    lstCrediCards.get(cards).Default__c=false;
                }
                UPDATE lstCrediCards.values();
            }
        }
        
       
        
    }