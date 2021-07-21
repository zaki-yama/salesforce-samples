@isTest
public with sharing class UnitOfWorkTest {

    @isTest
    static void challengeComplete() {

        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            });

        for (Integer i = 0; i < 100; i++) {
            Account acc = new Account();
            acc.Name = 'Account : ' + i;
            uow.registerNew(acc);

            for (Integer j = 0; j < 5; j++) {
                Contact con = new Contact();
                con.LastName = 'Contact : ' + j;
                uow.registerNew(con, Contact.AccountId, acc);

                Note n = new Note();
                n.Title = 'Note : ' + j;
                uow.registerNew(n, Note.ParentId, acc);
            }

        }

        uow.commitWork();

        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }
}
