trigger QuoteTrigger on SBQQ__Quote__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new QuoteTriggerHandler(SBQQ__Quote__c.getSObjectType()).run();
}