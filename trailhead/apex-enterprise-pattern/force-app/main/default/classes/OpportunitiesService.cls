public with sharing class OpportunitiesService {
    public static void applyDiscounts(Set<Id> opportunityIds, Decimal discountPercentage) {
        // Unit of WebServiceMock
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new List<SobjectType> { OpportunityLineItem.SObjectType, Opportunity.SObjectType });

        // Validate parameters
        if (opportunityIds == null || opportunityIds.size() == 0)
            throw new OpportunityServiceException('Opportunities not specified.');
        if (discountPercentage < 0 || discountPercentage > 100)
            throw new OpportunityServiceException('Invalid discount to apply.');

        // Query Opportunities and Lines (SOQL inlined for this example, see Selector pattern in later module)
        List<Opportunity> opportunities =
        [select Amount, (select UnitPrice from OpportunityLineItems)
         from Opportunity where Id in :opportunityIds];
        // Update Opportunities and Lines (if present)
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        List<OpportunityLineItem> oppLinesToUpdate = new List<OpportunityLineItem>();
        Decimal factor = 1 - (discountPercentage==null ? 0 : discountPercentage / 100);
        for (Opportunity opportunity : opportunities) {
            // Apply to Opportunity Amount
            if (opportunity.OpportunityLineItems!=null && opportunity.OpportunityLineItems.size()>0) {
                for (OpportunityLineItem oppLineItem : opportunity.OpportunityLineItems) {
                    oppLineItem.UnitPrice = oppLineItem.UnitPrice * factor;
                    uow.registerDirty(oppLineItem);
                }
            } else {
                opportunity.Amount = opportunity.Amount * factor;
                uow.registerDirty(opportunity);
            }
        }

        // Commit Unit of Work
        uow.commitWork();
    }
    public class OpportunityServiceException extends Exception {}
}
