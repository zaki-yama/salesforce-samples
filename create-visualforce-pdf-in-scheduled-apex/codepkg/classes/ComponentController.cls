public class ComponentController {

	public String opportunityId {get; set;}

	public Opportunity getOpp() {

		System.debug(LoggingLevel.INFO, this.opportunityId);
		return [
			SELECT
				Name,
				(SELECT Product2.Name, UnitPrice, Quantity FROM OpportunityLineItems)
			FROM Opportunity
			WHERE Id = :this.opportunityId
		][0];
	}
}
