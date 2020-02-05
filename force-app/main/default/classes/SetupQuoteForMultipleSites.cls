public with sharing class SetupQuoteForMultipleSites {
    public static void createChildOpportunities (List<SBQQ__Quote__c> quoteList) {

        List<SBQQ__Quote__c> quotesForSecondarySites = new List<SBQQ__Quote__c>();
        List<Opportunity> newOpportunities = new List<Opportunity>();
        Set<Id> accIds = new Set<Id>();
        
        for (SBQQ__Quote__c quoteCurrent : quoteList){
            //check if quote is intended for a secondary site
            if (quoteCurrent.Secondary_Site__c == TRUE){
                //add quote to list
                quotesForSecondarySites.add(quoteCurrent);
                accIds.add(quoteCurrent.SBQQ__Account__c);
            }
        }

        for (SBQQ__Quote__c quoteCurrent : quotesForSecondarySites){
                //create a new opportunity for the secondary site quote
                Opportunity newOppt = new Opportunity(
                    Name = 'Site Opportunity of '+ quoteCurrent.SBQQ__Opportunity2__r.Name, 
                    StageName='Prospecting', 
                    CloseDate=quoteCurrent.SBQQ__ExpirationDate__c,
                    //relate the new opportunity to the current one (the parent opportunity)
                    ParentOpportunity__c = quoteCurrent.SBQQ__Opportunity2__c, 
                    //assign the new opportunity to the quote, allowing the quote to use standard CPQ ordering functionality
                    SBQQ__PrimaryQuote__c = quoteCurrent.Id
                );
                //add the new opportunity to a list of opportunities to be inserted in bulk
                newOpportunities.add(newOppt);   
        }
        insert newOpportunities;
    }
}