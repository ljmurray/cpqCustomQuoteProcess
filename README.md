Idea for the CPQ Custom Quote Process:

Use Case:

Business wants to create multiple quotes from one opportunity that all can be generated into orders
Opportunity is long-term/programmatic/multiple sites and locations--desire to create multiple quotes and orders from one oppty
Users will create a quote from the programmatic opportunity as normal
Logic in the background will create child opportunities for each of the quotes and relate those child opportunities back to the programmatic opportunity

Design:
Create parent-child structure on the Opportunity object

Custom fields:

Opportunity.
OpportunityType__c - picklist to determine whether opportunity is "Programmtic" or "One-Time"
ParentOpportunity__c - lookup to Opportunity object
QuotedTotalFromAllSites__c - currency field to be inserted with sum of all primary quotes on the children opportunities

SBQQ__Quote__c.
Secondary_Site__c - checkbox to denote that a quote is for a second site; will automatically be checked when a user creates a quote from a programmatic opportunity