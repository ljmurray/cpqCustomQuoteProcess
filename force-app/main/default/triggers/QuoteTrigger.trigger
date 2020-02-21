trigger QuoteTrigger on SBQQ__Quote__c (after insert) {
    if(trigger.isAfter && trigger.isInsert) {
        SetupQuoteForMultipleSites.createChildOpportunities((List<SBQQ__Quote__c>)Trigger.New);
    }
}