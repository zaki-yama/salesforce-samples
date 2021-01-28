public with sharing class AccountController {
  @AuraEnabled(cacheable=true)
  public static List<Contact> getRelatedContacts(String accountId) {
    return [
      SELECT Name, Title, Email, Phone
      FROM Contact
      WHERE AccountId = :accountId
      WITH SECURITY_ENFORCED
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    return [
      SELECT Name, AnnualRevenue, Industry
      FROM Account
      WITH SECURITY_ENFORCED
      ORDER BY Name
    ];
  }
}
