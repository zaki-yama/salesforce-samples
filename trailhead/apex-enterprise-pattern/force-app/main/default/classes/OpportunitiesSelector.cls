public with sharing class OpportunitiesSelector extends fflib_SObjectSelector {
  public List<OpportunityInfo> selectOpportunityInfo(Set<Id> idSet) {
    List<OpportunityInfo> opportunityInfos = new List<OpportunityInfo>();
    for (
      Opportunity opportunity : Database.query(
        newQueryFactory(false)
          .selectField(Opportunity.Id)
          .selectField(Opportunity.Amount)
          .selectField(Opportunity.StageName)
          .selectField('Account.Name')
          .selectField('Account.AccountNumber')
          .selectField('Account.Owner.Name')
          .setCondition('id in :idSet')
          .toSOQL()
      )
    )
      opportunityInfos.add(new OpportunityInfo(opportunity));
    return opportunityInfos;
  }

  public class OpportunityInfo {
    private Opportunity opportunity;
    public Id Id {
      get {
        return opportunity.Id;
      }
    }
    public Decimal Amount {
      get {
        return opportunity.Amount;
      }
    }
    public String Stage {
      get {
        return opportunity.StageName;
      }
    }
    public String AccountName {
      get {
        return opportunity.Account.Name;
      }
    }
    public String AccountNumber {
      get {
        return opportunity.Account.AccountNumber;
      }
    }
    public String AccountOwner {
      get {
        return opportunity.Account.Owner.Name;
      }
    }
    private OpportunityInfo(Opportunity opportunity) {
      this.opportunity = opportunity;
    }
  }
}
