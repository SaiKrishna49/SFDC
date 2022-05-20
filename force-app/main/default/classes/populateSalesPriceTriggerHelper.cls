public class populateSalesPriceTriggerHelper{   
   
    // start of OPP-25941 
    public static void createBulkopplineitems(map<id,opportunitylineitem> opplineprodumap,set<id> opportunityids){
        system.debug('opplineprodumap='+opplineprodumap);
        system.debug('opportunityids='+ opportunityids);
        list<opportunitylineitem> opplineitemlist = new list<opportunitylineitem>();
        list<Bundle_Component__c> bundledlist = new list<Bundle_Component__c>();
        map<opportunitylineitem, list<Bundle_Component__c>> bundledproductslistmap = new map<opportunitylineitem, list<Bundle_Component__c>>();
        // Start of OPP-26307
        list<string> opplineproductcodes = new list<string>();
      //  for(opportunity opp: [select id,(select id,productcode from opportunitylineitems) from opportunity where id IN: opplineprodumap.keyset()]){
            system.debug('opplineprodumap.values()=='+opplineprodumap.values());
            for(opportunitylineitem oppline: opplineprodumap.values()){
                opplineproductcodes.add(oppline.Product2Id);
                system.debug('opplineproductcodes='+opplineproductcodes);
            }
        
        // End of OPP-26307
        system.debug('opplineprodumap.keyset()='+opplineprodumap.keyset());
        for(product2 product: [select id, productcode, IsActive,
                               (select id, Product__c, Parent_Product__c from child_products__r)
                               from product2
                               where id IN: opplineproductcodes /*and IsActive =: True*/]){
                                   system.debug('opplineproductcodes='+opplineproductcodes);
                                   system.debug('product='+product);
                                   if(product.Bundle_Components__r.size()>0){
                                       system.debug('product.Bundle_Components__r.size()='+product.Bundle_Components__r.size());
                                       for(Bundle_Component__c bundleprod: product.Bundle_Components__r){
                                           system.debug('bundledproductslistmap.containskey(opplineprodumap.get(product.Id))=='+bundledproductslistmap.containskey(opplineprodumap.get(product.Id)));
                                           if(bundledproductslistmap.containskey(opplineprodumap.get(product.Id))){
                                               list<Bundle_Component__c> bundledcomponents = bundledproductslistmap.get(opplineprodumap.get(product.Id));
                                               system.debug('bundledcomponents before add=='+bundledcomponents);
                                               system.debug('bundleprod before add='+ bundleprod);
                                               bundledcomponents.add(bundleprod);
                                               system.debug('bundledcomponents after add of bundleprod='+bundledcomponents);
                                               bundledproductslistmap.put(opplineprodumap.get(product.Id),bundledcomponents);
                                               system.debug('bundledproductslistmap='+bundledproductslistmap);
                                           }
                                           else{
                                               system.debug('else loop');
                                               list<Bundle_Component__c> listofbundlecomp =new list<Bundle_Component__c>();
                                               listofbundlecomp.add(bundleprod);
                                               system.debug('listofbundlecomp in else='+listofbundlecomp);
                                               bundledproductslistmap.put(opplineprodumap.get(product.Id), listofbundlecomp );
                                               system.debug('bundledproductslistmap after else=='+bundledproductslistmap);
                                           }  
                                       }
                                   }
                                   
                               }
        map<opportunitylineitem,set<id>> opplinebundleIDs = new  map<opportunitylineitem,set<id>>();
        for(opportunitylineitem oppline: bundledproductslistmap.keyset()){
            for(Bundle_Component__c bundlecomp: bundledproductslistmap.get(oppline)){
                system.debug('opplinebundleIDs.containskey(oppline)=='+opplinebundleIDs.containskey(oppline));
                if(opplinebundleIDs.containskey(oppline)){
                    set<id> bundleids = opplinebundleIDs.get(oppline);
                    bundleids.add(bundlecomp.Id);
                    opplinebundleIDs.put(oppline,bundleids);
                    system.debug('opplinebundleIDs=='+opplinebundleIDs);
                    system.debug('bundleids='+bundleids);
                }
                else{
                    
                    opplinebundleIDs.put(oppline, new set<id> {bundlecomp.Id});
                    system.debug('opplinebundleIDs in else='+opplinebundleIDs);
                }  
            }
        }
        list<opportunitylineitem> opplinelist = new list<opportunitylineitem>();
        for(opportunitylineitem oppline: opplinebundleIDs.keyset()){
            system.debug('opplinebundleIDs.keyset()=='+opplinebundleIDs.keyset());
            for(Bundle_Component__c bundlecomp: [select id, Bundled_Product__r.id,Parent_Product__c 
                                                 from Bundle_Component__c 
                                                 where id IN: opplinebundleIDs.get(oppline) ]){
                                                     // start of  OPP-26307
                                                     if(!opplineproductcodes.contains(bundlecomp.Bundled_Product__r.productcode)){
                                                         // End of OPP-26307
                                                         opportunitylineitem opplineitem = new opportunitylineitem();                                                     
                                                       //  opplineitem.Student_User__c = oppline.Student_User__c;
                                                         opplineitem.Quantity = 1;
                                                         opplineitem.OpportunityId = oppline.OpportunityId;
                                                       //  opplineitem.Is_Bundle_Component__c = true;
                                                         opplineitem.TotalPrice = 0;
                                                       //  opplineitem.Parent_SKU__c=oppline.productcode; //Added OPP-33070
                                                         opplineitem.Product2Id = bundlecomp.Bundled_Product__r.id;
                                                        opplineitem.PricebookEntryId = oppline.PricebookEntryId;
                                                        // opplineitem.Product_Code__c = bundlecomp.Bundled_Product__r.productcode;
                                                         system.debug('bundle productcode'+bundlecomp.Bundled_Product__r.productcode);
                                                         
                                                         opplinelist.add(opplineitem);  
                                                         system.debug('opplinelist=='+opplinelist);
                                                     }
                                                 }
        }
        system.debug('opplinelist.size()='+opplinelist.size());
        if(opplinelist.size()>0){
          //  RecursiveTriggerHandler.bundleskusvar = false;
            system.debug('opplinelistBeforeInsert'+opplinelist);
            insert opplinelist;
            system.debug('opplinelist=='+opplinelist);
          //  RecursiveTriggerHandler.isFirstTime=true;
           // RecursiveTriggerHandler.recursivevar = true;
            system.debug('opplinelistAfterInsert'+opplinelist);
        }
    }
    // End of OPP-25941

 /*   public static void calculatePartPrice(list<OpportunityLineItem> lineItems, Boolean fromOpportunity)
    {
        try {
            map<Id,Id> mapOppPartner = new map<Id,Id>();
            set<Id> opportunityIds = new set<Id>();
            map<Id, Magento_Partner__c> partnerIds = new map<Id, Magento_Partner__c>();
            map<String, Double> amountDiscountMap = new map<String, Double>();
            map<String, Decimal> percentDiscountMap = new map<String, Decimal>();
            map<String, Double> priceDiscountMap = new map<String, Double>();
            map<String, ID> amountPriceRuleMap = new map<String, ID>();
            for(OpportunityLineItem ol : lineItems)
            {
                if(ol.Is_Bundle_Component__c ==false)
                opportunityIds.add(ol.OpportunityID);
            }
            for(Opportunity op : [Select Magento_Partner__c from Opportunity Where ID IN : opportunityIds])
            {
                partnerIds.put(op.Magento_Partner__c, null);
                mapOppPartner.put(op.Id, op.Magento_Partner__c);
            }
            partnerIds = PartnerPricingHelper.loadPartners(partnerIds.keySet());
            
            Map<Id, PricebookEntry> pbes = new Map<id, PricebookEntry>();
            for(OpportunityLineItem ol : lineItems){
                if(ol.Is_Bundle_Component__c ==false)
                pbes.put(ol.PricebookEntryId, null);
            }
            pbes = new Map<id, PricebookEntry>([select Id, Product2.State__c, product2.Discipline__c, product2.hours__c, product2.Content_Type__c, product2.Delivery_Type__c, product2.ProductCode, product2.Business_Unit__c from PricebookEntry where Id in :pbes.KeySet()]);
            
            
            StateHelper sh = new statehelper();
            for(OpportunityLineItem ol : lineItems){
                if(ol.Is_Bundle_Component__c ==false){
                MagentoSupport.MagentoProductDetails mg = new MagentoSupport.MagentoProductDetails();
                PricebookEntry pbe = pbes.get(ol.PricebookEntryId);
                mg.hours = pbe.Product2.Hours__c;
                mg.discipline = pbe.Product2.Discipline__c;
                mg.state = pbe.Product2.State__c;
                mg.delivery_type = pbe.Product2.Delivery_Type__c;
                mg.sku = pbe.Product2.ProductCode;
                mg.business_unit = pbe.Product2.Business_Unit__c;
                mg.education_type = pbe.Product2.Content_Type__c;
                
                Magento_Partner__c partner = partnerIds.get(string.valueOf(mapOppPartner.get(ol.OpportunityID)));
                System.debug('POPULATESALESPRICETRIGGERHELPER: PARTNER: '+ (partner == null ? 'IS NULL': 'IS NOT NULL')+ ' FOR LINE ITEM: '+ ol.Id +' ON ORDER: '+ ol.OpportunityId);
                
                if (partner != null) {
                    Pricing_Rule__c pr = partnerpricinghelper.findMatchingRule(mg, partner.Pricing_Rules__r, sh);
                    if (partner.Zero_Dollar_Orders__c) {
                        priceDiscountMap.put(ol.Id, 0);
                    } else if (pr != null) {
                        if (pr.Discount_Amount__c != null && pr.Discount_Amount__c != 0){
                            amountDiscountMap.put(ol.Id, pr.Discount_Amount__c);
                        } else if(pr.Discount__c != null && pr.Discount__c != 0){
                            percentDiscountMap.put(ol.Id, pr.Discount__c);
                        } else if(pr.Price__c != null && pr.Price__c != 0){
                            priceDiscountMap.put(ol.Id, pr.Price__c);
                        }
                    }
                    if(amountDiscountMap.containsKey(ol.Id)) {
                        ol.UnitPrice = ol.ListPrice - amountDiscountMap.get(ol.Id); 
                    } else if(percentDiscountMap.containsKey(ol.Id)) {
                        ol.UnitPrice = ol.ListPrice - (ol.ListPrice * (percentDiscountMap.get(ol.Id)/100)); 
                    } else if(priceDiscountMap.containsKey(ol.Id)){
                        ol.UnitPrice = priceDiscountMap.get(ol.Id);
                    }

                    ol.Pricing_rule_Applied__c = pr == null ? null : pr.Id;
                    
                }
                }
            }
            
            if (fromOpportunity) {
                update lineItems;
            }
        }
        catch (Exception ex) {
            System.debug('ERROR IN CLASS populateSalesPriceTriggerHelper: '+ ex.getMessage()+'\n'+ex.getStackTraceString());
        }
    }*/
    
}