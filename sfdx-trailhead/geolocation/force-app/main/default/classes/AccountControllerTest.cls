@isTest
public with sharing class AccountControllerTest {

    @isTest
    private static void testFindAll() {
        insert new Account(
            Name = 'Test Account',
            Location__Latitude__s = 1,
            Location__Longitude__s = 1);

        System.assertEquals(1, AccountController.findAll().size());
    }
}
