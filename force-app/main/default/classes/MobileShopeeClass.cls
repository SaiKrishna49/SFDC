public class MobileShopeeClass {
    Public static void NewCustomerDiscount(list<mobile__c> MobileList1){
        for(Mobile__c m:MobileList1 ){
            if(m.brand__c == 'Samsung'){
                m.Price__c = m.price__c - (m.price__c *10)/100;
				m.Discount_Status__c = 'You have got 10% discount';
            }else if(m.brand__c == 'Apple'){
                 m.Price__c = m.price__c - (m.price__c *20)/100;
				m.Discount_Status__c = 'You have got 20% discount';
            }
        }
    }

    Public static void OldCustomerDiscount(list<mobile__c> MobileList2){
        for(Mobile__c m:MobileList2 ){
            if(m.brand__c == 'Samsung'){
                m.Price__c = m.price__c - (m.price__c *5)/100;
				m.Discount_Status__c = 'You have got 5% discount';
            }else if(m.brand__c == 'Apple'){
				m.Discount_Status__c = 'Sorry no discount as of now';
            }
        }
    }
}