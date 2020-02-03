public with sharing class SetupQuoteForMultipleSites {
    public SetupQuoteForMultipleSites(List<SBQQ__Quote__c> quoteList) {
        List<Opportunity> newOpportunites = new List<Opportunity>();
        for (SBQQ__Quote__c quoteCurrent : quoteList){
            //check if quote is intended for a secondary site
            if (quoteCurrent.Secondary_Site__c == TRUE){
                //create a new opportunity for the secondary site quote
                //relate the new opportunity to the current one (the parent opportunity)
                Opportunity newOppt = new Opportunity(Name = 'Site Opportunity of '+quoteCurrent.SBQQ__Opportunity2__c.Name, ParentOpportunity__c = quoteCurrent.SBQQ__Opportunity2__c);
                
                //assign the new opportunity to the quote, allowing the quote to use standard CPQ ordering functionality
                quoteCurrent.SBQQ__Opportunity2__c = newOppt;
                
                //add the new opportunity to a list of opportunities to be inserted in bulk
                newOpportunities.add(newOppt);
            } else {
                //do nothing for time being

            }
        }
        insert newOpportunities;
    }
}