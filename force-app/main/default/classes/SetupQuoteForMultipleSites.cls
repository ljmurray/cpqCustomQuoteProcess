public with sharing class SetupQuoteForMultipleSites {
    public static void createChildOpportunities(List<SBQQ__Quote__c> quoteList) {

        List<SBQQ__Quote__c> quotesForSecondarySites = new List<SBQQ__Quote__c>();
        //Set<Id> accIds = new Set<Id>();
        Set<Id> opptyIds = new Set<Id>();
        
        for (SBQQ__Quote__c quoteCurrent : quoteList){
            //check if quote is intended for a secondary site
            if (quoteCurrent.Secondary_Site__c == TRUE){
                //add quote to list
                quotesForSecondarySites.add(quoteCurrent);
                //accIds.add(quoteCurrent.SBQQ__Account__c);
                opptyIds.add(quoteCurrent.SBQQ__Opportunity2__c);
            }
        }
        
        Map<Id, Opportunity> opptyParentMap = new Map<Id, Opportunity>([SELECT Id, Name FROM Opportunity WHERE Id IN: opptyIds]);
        //List<Opportunity> newOpportunities = new List<Opportunity>();
        Map<Id,Opportunity> childOpportunitiesBySourceQuoteId = new Map<Id,Opportunity>();
        
        for (SBQQ__Quote__c quoteCurrent : quotesForSecondarySites){
                //create a new opportunity for the secondary site quote
                Opportunity newOppt = new Opportunity(
                    Name = 'Site Opportunity of '+ opptyParentMap.get(quoteCurrent.SBQQ__Opportunity2__c).Name, 
                    StageName='Prospecting', 
                    CloseDate=quoteCurrent.SBQQ__ExpirationDate__c,
                    //relate the new opportunity to the current one (the parent opportunity)
                    ParentOpportunity__c = quoteCurrent.SBQQ__Opportunity2__c
                );

                //add the new opportunity to a list of opportunities to be inserted in bulk
                //newOpportunities.add(newOppt);   
                childOpportunitiesBySourceQuoteId.put(quoteCurrent.Id,newOppt);
        }
        insert childOpportunitiesBySourceQuoteId.values();

        //run through the new quotes and assign them to the new opportunities
        List<SBQQ__Quote__c> quotesToUpdate = new List<SBQQ__Quote__c>([SELECT Id, Name, SBQQ__Opportunity2__c FROM SBQQ__Quote__c WHERE Id IN: childOpportunitiesBySourceQuoteId.keySet()]);
        for (SBQQ__Quote__c qt : quotesToUpdate){
            qt.SBQQ__Opportunity2__c = childOpportunitiesBySourceQuoteId.get(qt.Id).Id;
        }
        update quotesToUpdate;
    }
}