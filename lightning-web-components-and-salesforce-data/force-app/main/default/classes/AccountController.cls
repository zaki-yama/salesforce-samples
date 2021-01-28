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
}
