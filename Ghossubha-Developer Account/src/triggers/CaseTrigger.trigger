trigger CaseTrigger on Case (before insert,before update,before delete,after insert,after update,after delete,
                             after undelete) {
    if(trigger.IsUpdate && trigger.IsBefore) {
        ExecuteUpdateCaseSubject__c updCase = [select id, name, ExecuteOnBeforeUpdate__c from ExecuteUpdateCaseSubject__c where name = 'UpdateCaseSubjectOnBeforeUpdate'];
        updCase.ExecuteOnBeforeUpdate__c = false;
        update updCase;
    }
    if(Trigger.isBefore && Trigger.isInsert) {
        for(Case cse: Trigger.new) {
            if(cse.CaseAsset__c != null) {
                system.debug('@Case Asset@'+cse.CaseAsset__c);
            }
        }
    }
}