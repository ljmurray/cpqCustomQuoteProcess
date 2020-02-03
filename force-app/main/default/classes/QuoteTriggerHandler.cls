public with sharing class QuoteTriggerHandler extends TriggerHandler {
    public QuoteTriggerHandler() {

    }
    public override void afterInsert(){
        SetupQuoteForMultipleSites.SetupQuoteForMultipleSites((List<SBQQ__Quote__c>)trigger.New);
    }
}
