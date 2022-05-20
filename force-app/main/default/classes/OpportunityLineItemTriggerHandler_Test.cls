@istest(SeeAllData=true)
private class OpportunityLineItemTriggerHandler_Test {
    
    @istest
     static void TestMethodAfterinsert(){
        list<Opportunity> oppList = new list<Opportunity>{new Opportunity(Name = 'Test 1', StageName='Prospecting',CloseDate = system.today()),
            new Opportunity(Name = 'test 2', StageName ='Prospecting',CloseDate = system.today())};
                INSERT oppList;
     
            
        
        Pricebook2 pb22 = new Pricebook2(Name='testDIE');
        insert pb22;
        
            list<Product2> pro2List = new list<Product2>{new Product2(Name='laptop', isActive=true),
                new Product2(Name='Laptopbag', isActive=true)};
        insert pro2List;
            for(Product2 prodRec : pro2List){
            child_product__c chldProd = new child_product__c(Parent_Product__c = pro2List[0].Id, Product__c=pro2List[1].Id );
        PricebookEntry pbe2 =new PricebookEntry(Product2Id=pro2List[0].Id,Pricebook2Id=Test.getStandardPricebookId(),UnitPrice=1
                                                );
        insert pbe2;
        
        OpportunityLineItem OPplineitem2 = new OpportunityLineItem (Quantity=2, OpportunityId=oppList[0].Id,UnitPrice=1,PriceBookEntryId=pbe2.Id);
        insert OPplineitem2;
                list<opportunity> Optylist = [SELECT id, (SELECT id FROM OpportunityLineItems) FROM opportunity WHERE Id In:oppList];
         system.assertEquals(2, Optylist.size());
        }
        
    }
}