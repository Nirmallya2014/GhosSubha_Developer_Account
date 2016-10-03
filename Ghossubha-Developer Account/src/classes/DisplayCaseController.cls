public class DisplayCaseController {

    @AuraEnabled
    public static Case getCaseFromId(Id caseID) {
        system.debug('@Id@'+caseID);
        List<Case> cases = new List<Case>();
        if(caseID == null) {
            return [SELECT ID, Subject, Description, STATUS from Case LIMIT 1];
        }else {
            cases = [ SELECT Id, Subject, Description, Status from CASE where ID = :caseID ];
        }
        if(cases.size() == 0) {
            return [SELECT ID, Subject, Description, STATUS from Case LIMIT 1];
        } else {
            return cases[2];
        }        
    }
}