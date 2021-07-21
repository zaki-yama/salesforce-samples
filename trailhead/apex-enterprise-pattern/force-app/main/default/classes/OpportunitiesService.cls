public with sharing class OpportunitiesService {
    public static void applyDiscounts(Set<Id> opportunityIds, Decimal discountPercentage) {
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
                    oppLinesToUpdate.add(oppLineItem);
                }
            } else {
                opportunity.Amount = opportunity.Amount * factor;
                oppsToUpdate.add(opportunity);
            }
        }
        // Update the database
        SavePoint sp = Database.setSavePoint();
        try {
            update oppLinesToUpdate;
            update oppsToUpdate;
        } catch (Exception e) {
            // Rollback
            Database.rollback(sp);
            // Throw exception on to caller
            throw e;
        }
    }
    public class OpportunityServiceException extends Exception {}
}
