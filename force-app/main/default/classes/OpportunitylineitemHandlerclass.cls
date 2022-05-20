public class OpportunitylineitemHandlerclass
{
    public static boolean flag=true;
   Public static void afterInsert(List<OpportunityLineItem> LineList, Map<Id, OpportunityLineItem> newMap)
    {
        if(flag){
            flag=false;
        set<Id> parentproductids = new set<Id>();
        set<id> childprodIds = new set<Id>();
        set<id> pricebookIds=new set<id>();
        Map<Id,Set<Id>> productIdToChildProductIds = new Map<Id,Set<Id>>();
        //List<OpportunityLineItem> linelist=(List<OpportunityLineItem>)newList;
        //Map<Id,OpportunityLineItem> oppLineItemsMap=new Map<Id,OpportunityLineItem>(linelist);
        for(OpportunityLineItem opp:linelist)
        {
            parentproductids.add(opp.product2Id);
            pricebookIds.add(opp.opportunity.pricebook2Id);
            System.debug('pricebookIds=='+ pricebookIds);
            System.debug('parentproductids=='+parentproductids);
        }
        
        if(parentproductids.size()>0){
            for(child_product__c cids:[SELECT Product__c,Parent_Product__c FROM child_product__c WHERE Parent_Product__c IN:parentproductids])
            {
                childprodIds.add(cids.Product__c);
               
                if(productIdToChildProductIds.containsKey(cids.Parent_Product__c))
                {
                    productIdToChildProductIds.get(cids.Parent_Product__c).add(cids.Product__c);
                    system.debug('productIdToChildProductIds  get:'+ productIdToChildProductIds);
                }
                else
                {
                    productIdToChildProductIds.put(cids.Parent_Product__c, new set<Id>{cids.Product__c});
                    system.debug('productIdToChildProductIds else='+ productIdToChildProductIds);
                }
            }
        }
        List<OpportunityLineItem> childOpportunityLineItems = new List<OpportunityLineItem>();
        for(OpportunityLineItem lineItem :linelist)
        {
           
            if(productIdToChildProductIds.containsKey(lineItem.Product2Id))
            {
               
                for(Id childProductId : productIdToChildProductIds.get(lineItem.Product2Id))
                {
                    system.debug('childProductId=='+ childProductId);
                    OpportunityLineItem childItem = new OpportunityLineItem();
                    childItem.Product2Id = childProductId;
                    childItem.OpportunityId = lineItem.OpportunityId;
                    childItem.Quantity = lineItem.Quantity;
                    childItem.UnitPrice = 0;
                    childItem.PricebookEntryId = lineItem.PricebookEntryId;
                    childOpportunityLineItems.add(childItem);
                   
                }
            }
        }
       
        if(!childOpportunityLineItems.isEmpty())
        {
            try
            {
                INSERT childOpportunityLineItems;
                system.debug('childOpportunityLineItems=='+childOpportunityLineItems);
            }
            catch(Exception error)
            {
                System.debug('Error::'+error.getMessage());
            }
        }
        }
    }
}