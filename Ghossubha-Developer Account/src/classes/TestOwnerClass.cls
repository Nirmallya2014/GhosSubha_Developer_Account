public class TestOwnerClass {
    
    public TestOwnerClass() {
        
    }
    
    public PageReference updateCase() {
        String caseIds = ApexPages.currentPage().getParameters().get('caseId');
        Case updatedCase = [select id,UpdateCase__c,OwnerId,CaseNumber from case where id =: caseIds];
        system.debug('@Owner@'+updatedCase.OwnerId);
        if(updatedCase.OwnerId == userinfo.getUserId()) {
            updatedCase.UpdateCase__c = false;
            update updatedCase;
            system.debug('@Owner@In False');
        }else {
            updatedCase.UpdateCase__c = true;
            update updatedCase;
            system.debug('@Owner@In True');
        }
        system.debug('Updated Case:'+updatedCase);
        return null;
    }
}