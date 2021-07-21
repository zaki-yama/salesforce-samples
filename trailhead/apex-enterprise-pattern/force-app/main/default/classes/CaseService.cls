public with sharing class CaseService {
    public static void closeCases(Set<ID> caseIds, String reason) {
        List<Case> cases = [SELECT Id, Reason FROM Case WHERE Id IN :caseIds];
        for (Case c : cases) {
            c.Reason = reason;
            c.Status = 'Closed';
        }
        update cases;
    }
}
