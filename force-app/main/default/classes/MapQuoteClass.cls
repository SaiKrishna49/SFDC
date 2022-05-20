public class MapQuoteClass {
    public static void QuoteID(list<opportunity> opplist, map<id,Opportunity> oldmap, map<id,Opportunity> newmap){
        list<case> caselist = new list<case>();
		list<Quote> Quotelist = new list<Quote>();
     opplist = [select id,StageName, (select id from Quotes) from opportunity WHere StageName = 'Closed won' AND ID IN:newmap.keyset()];
        for(opportunity opp : opplist) {
            for(Quote Quo : opp.Quotes){
                system.debug('Quotes for loop' + opp.Quotes);
                case c = new case();
               c.Opportunity__c = opp.id;
                c.Quote__c = opp.id;
                
               system.debug('c.opp in case' + c.Opportunity__c );
                 system.debug('c.Quote in case' + c.Quote__c );
                   caselist.add(c);
            }
        }
            for (opportunity opp:opplist){
              caselist[0].Quote__c = Quotelist[0].id;  
                }
                update caselist;
            }
                
            }