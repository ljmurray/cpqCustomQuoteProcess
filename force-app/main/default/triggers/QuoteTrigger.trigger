trigger QuoteTrigger on SBQQ__Quote__c (after insert) {
    SetupQuoteForMultipleSites.createChildOpportunities((List<SBQQ__Quote__c>)Trigger.New);
}