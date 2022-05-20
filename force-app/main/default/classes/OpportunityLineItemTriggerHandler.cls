/**************************************************************************************************
*** Class Name             : OpportunityLineItemTriggerHandler
*** Class Description      : This class is used to add child products of parent products to its related opportunity line Item.
*** Author                 : Krishna
*** Class Created Date     : 15-Nov-2021.
****************************************************************/



public class OpportunityLineItemTriggerHandler implements ITriggerHandler{
      @TestVisible
  private TriggerContext context;

  // the current context of the trigger, overridable in tests
  @TestVisible
  private Boolean isTriggerExecuting;
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
     
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
     
    public void beforeInsert(List<sObject> newList) {
         
    }
     
    public void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
           set<id> parentProductIdSet = new set<id>();
        set<id> childProductIdSet = new set<id>();
        set<id> priceBookEntryIdSet = new set<id>();
        map<id,set<id>> producttoChildProductIdMap = new map<id,set<id>>();
        map<id,id> product2idToProceBookEntryid = new map<id,id>(); 
        list<OpportunityLineItem> oppLineItemList = (list<OpportunityLineItem>)(newList);
        map<id,OpportunityLineItem> opplineItemMap = new map<id,OpportunityLineItem>(oppLineItemList);
        for(OpportunityLineItem opp : opplineItemMap.values()){
            parentProductIdSet.add(opp.Product2Id);
        }
        for(OpportunityLineItem oppLine : [SELECT id,opportunity.priceBook2Id FROM OpportunityLineItem WHERE id IN:opplineItemMap.keyset()]){
            priceBookEntryIdSet.add(oppLine.opportunity.priceBook2Id);
        }
        for(Child_Product__c  ChildprodRec : [SELECT id,Product__c,Parent_Product__c FROM Child_Product__c WHERE Parent_Product__c IN:parentProductIdSet]){
            childProductIdSet.add(ChildprodRec.Product__c);
            
            if(productTOChildProductIdMap.containskey(ChildprodRec.Product__c)){
                productTOChildProductIdMap.get(ChildprodRec.Parent_Product__c).add(ChildprodRec.Product__c);
            }
            else{
                set<id> chldprodIdSet = new set<id>();
                chldprodIdSet.add(ChildprodRec.Product__c);
                productTOChildProductIdMap.put(ChildprodRec.Parent_Product__c , chldprodIdSet);
            }
            if(!childProductIdSet.isEmpty()){
                for(PriceBookEntry priceBookEntryRec : [SELECT id,Product2Id,Product2.Id,Product2.name FROM PriceBookEntry WHERE Product2Id IN:childProductIdSet AND Pricebook2Id IN:priceBookEntryIdSet]){
                    product2idToProceBookEntryid.put(priceBookEntryRec.Product2Id , priceBookEntryRec.Id);
                }
            }
            list<OpportunityLineItem> childOppLineItemList = new list<OpportunityLineItem>();
            for(OpportunityLineItem oppLineRec : opplineItemMap.values()){
                if(productTOChildProductIdMap.containskey(oppLineRec.Product2Id)){
                    for(id idRec: productTOChildProductIdMap.get(oppLineRec.Product2Id)){
                        OpportunityLineItem newOppLineItem = new OpportunityLineItem();
                        newOppLineItem.OpportunityId = oppLineRec.OpportunityId;
                        newOppLineItem.Product2Id = idRec;
                        newOppLineItem.TotalPrice = 0;
                        newOppLineItem.PricebookEntryId = product2idToProceBookEntryid.get(idRec);
                        newOppLineItem.Quantity = 1;
                        childOppLineItemList.add(newOppLineItem);
                    }
                }
            }
            if(childOppLineItemList.size()>0){
                try{
                    INSERT childOppLineItemList;
                    system.debug('childOppLineItemList='+childOppLineItemList);
                }
                catch(Exception e){
                    system.debug('Error is :'+ e);
                }
            }
            
        }
         
    }
     
    public void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
     
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
     
    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
     
    public void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
        set<id> parentproductIdSet = new set<id>();
        set<id> opportunityIdset = new set<id>();
        set<id> childProductIdSet = new set<id>();
        list<OpportunityLineItem> LineItemlist =(list<OpportunityLineItem>)oldList;
        map<id,OpportunityLineItem> oppLineItemsMap = new map<id,OpportunityLineItem>(LineItemlist);
        for(OpportunityLineItem oppLineitemRec : oppLineItemsMap.values()){
            parentproductIdSet.add(oppLineitemRec.product2id);
            opportunityIdset.add(oppLineitemRec.opportunityid);
        }
        for(child_product__c childProdRec : [SELECT id,Parent_Product__c,Product__c FROM child_product__c 
												WHERE Parent_Product__c IN:parentproductIdSet]){
            childProductIdSet.add(childProdRec.Product__c);
            if(childProductIdSet.size() > 0){
                try{
                   list<OpportunityLineItem> OppLinetemListToDelete = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId IN : opportunityIdset AND Product2Id IN : childProductIdSet];
                    DELETE OppLinetemListToDelete;
                }catch(Exception e){
                    system.debug('Error is : '+ e);
                }
            }
        } 
        
    }
     
    public void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
         
    }
}



/*public class OpportunityLineItemTriggerHandler IMPLEMENTS ITriggerHandler{
    
    public static Boolean TriggerDisabled = false;
     
    //check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
    public void beforeInsert(List<sObject> newList) {
         
    }
   public void afterInsert(Map<Id, sObject> newMap) {
        set<id> parentProductIdSet = new set<id>();
        set<id> childProductIdSet = new set<id>();
        set<id> priceBookEntryIdSet = new set<id>();
        map<id,set<id>> producttoChildProductIdMap = new map<id,set<id>>();
        map<id,id> product2idToProceBookEntryid = new map<id,id>(); 
        for(OpportunityLineItem opp : newMap.values()){
            parentProductIdSet.add(opp.Product2Id);
        }
        for(OpportunityLineItem oppLine : [SELECT id,opportunity.priceBook2Id FROM OpportunityLineItem WHERE id IN:newMap.keyset()]){
            priceBookEntryIdSet.add(oppLine.opportunity.priceBook2Id);
        }
        for(Child_Product__c  ChildprodRec : [SELECT id,Product__c,Parent_Product__c FROM Child_Product__c WHERE Parent_Product__c IN:parentProductIdSet]){
            childProductIdSet.add(ChildprodRec.Product__c);
            
            if(productTOChildProductIdMap.containskey(ChildprodRec.Product__c)){
                productTOChildProductIdMap.get(ChildprodRec.Parent_Product__c).add(ChildprodRec.Product__c);
            }
            else{
                set<id> chldprodIdSet = new set<id>();
                chldprodIdSet.add(ChildprodRec.Product__c);
                productTOChildProductIdMap.put(ChildprodRec.Parent_Product__c , chldprodIdSet);
            }
            if(!childProductIdSet.isEmpty()){
                for(PriceBookEntry priceBookEntryRec : [SELECT id,Product2Id,Product2.Id,Product2.name FROM PriceBookEntry WHERE Product2Id IN:childProductIdSet AND Pricebook2Id IN:priceBookEntryIdSet]){
                    product2idToProceBookEntryid.put(priceBookEntryRec.Product2Id , priceBookEntryRec.Id);
                }
            }
            list<OpportunityLineItem> childOppLineItemList = new list<OpportunityLineItem>();
            for(OpportunityLineItem oppLineRec : newMap.values()){
                if(productTOChildProductIdMap.containskey(oppLineRec.Product2Id)){
                    for(id idRec: productTOChildProductIdMap.get(oppLineRec.Product2Id)){
                        OpportunityLineItem newOppLineItem = new OpportunityLineItem();
                        newOppLineItem.OpportunityId = oppLineRec.OpportunityId;
                        newOppLineItem.Product2Id = idRec;
                        newOppLineItem.TotalPrice = 0;
                        newOppLineItem.PricebookEntryId = product2idToProceBookEntryid.get(idRec);
                        newOppLineItem.Quantity = 1;
                        childOppLineItemList.add(newOppLineItem);
                    }
                }
            }
            if(childOppLineItemList.size()>0){
                try{
                    INSERT childOppLineItemList;
                    system.debug('childOppLineItemList='+childOppLineItemList);
                }
                catch(Exception e){
                    system.debug('Error is :'+ e);
                }
            }
            
        }
    }
    
   public void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
    
    public void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
         
    }
    
    public void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
         
    }
    
    public void afterDelete(Map<Id,OpportunityLineItem> oppLineItemsMap){
        set<id> parentproductIdSet = new set<id>();
        set<id> opportunityIdset = new set<id>();
        set<id> childProductIdSet = new set<id>();
        for(OpportunityLineItem oppLineitemRec : oppLineItemsMap.values()){
            parentproductIdSet.add(oppLineitemRec.product2id);
            opportunityIdset.add(oppLineitemRec.opportunityid);
        }
        for(child_product__c childProdRec : [SELECT id,Parent_Product__c,Product__c FROM child_product__c 
												WHERE Parent_Product__c IN:parentproductIdSet]){
            childProductIdSet.add(childProdRec.Product__c);
            if(childProductIdSet.size() > 0){
                try{
                    DELETE [SELECT Id FROM OpportunityLineItem WHERE OpportunityId IN : opportunityIdset AND Product2Id IN : childProductIdSet];
                    
                }catch(Exception e){
                    system.debug('Error is : '+ e);
                }
            }
        }
    }
    
}*/
    
    
    
    
  
    
    
    
    
    
    
    /*List<Child_Product__c> childitems=new List<Child_Product__c>();
            Map<Id,List<Child_Product__c>> childProductMap=new Map<Id,List<Child_Product__c>>();
            List<OpportunityLineItem> optyLineList=new List<OpportunityLineItem>();
            Set<Id> productIds=new Set<Id>();
            for(OpportunityLineItem oppLineItem : oppLineItemsMap.values()){
                if(oppLineItem.OpportunityId!=NULL&&oppLineItem.Product2Id!=NULL){
                    productIds.add(oppLineItem.Product2Id);
                    System.debug(productIds);
                }
            }
            for(Product2 prodRecords : [SELECT Id,(SELECT Parent_Product__c,Product__c,Id FROM child_products1__r) FROM Product2
                                        WHERE Id IN : productIds]){
                                            childProductMap.put(prodRecords.Id,prodRecords.child_products1__r);
                                            System.debug(childProductMap);
                                        
            for(OpportunityLineItem lineItemRecord : oppLineItemsMap.values()){
                System.debug(childProductMap.get(lineItemRecord.product2Id).size());
                if(childProductMap.get(lineItemRecord.product2Id).size()>0){
                    for(Child_Product__c cRecord : childProductMap.get(lineItemRecord.product2Id)){
                        System.debug(cRecord.Product__c);
                        optyLineList.add(new OpportunityLineItem(OpportunityId=lineItemRecord.OpportunityId,
                                                                 Product2Id='01t5g000005FWTGAA4',
                                                                 Quantity=lineItemRecord.Quantity,
                                                                 TotalPrice=0,
                                                                 PricebookEntryId='01u5g0000059nIxAAI'));
                        System.debug(optyLineList);
                    }
                }
                }
            }
            
            if(!optyLineList.isEmpty()){
                INSERT optyLineList;
            }
        }
    }*/