@RestResource(urlMapping='/apexSecurityRest')
global with sharing class ApexSecurityRest {
    @HttpGet
    global static Contact doGet() {
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        if (recordId == null) {
           throw new FunctionalException('Id parameter is required');
        }
        if (Schema.SObjectType.Contact.isAccessible()
          && Schema.SObjectType.Contact.fields.Name.isAccessible()
          && Schema.SObjectType.Contact.fields.Top_Secret__c.isAccessible()
        ) {
          List<Contact> results = [SELECT id, Name, Title, Top_Secret__c, Account.Name FROM Contact WHERE Id = :recordId];
          if (!results.isEmpty()) {
             result = results[0];
             if (Schema.sObjectType.Contact.fields.Description.isUpdateable()){
                 result.Description = result.Account.Name;
                 }
             }
           } else {
             throw new SecurityException('You don\'t have access to all contact fields required to use this API');
           }
           return result;
      }
      public class FunctionalException extends Exception{}
      public class SecurityException extends Exception{}
}
