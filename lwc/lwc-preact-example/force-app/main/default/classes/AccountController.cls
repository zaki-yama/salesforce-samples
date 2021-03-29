public with sharing class AccountController {
  @AuraEnabled
  public static List<Account> getAccounts() {
    return [SELECT Id, Name FROM Account WITH_SECURITY_ENFORCED LIMIT 5];
  }
}
