public class CanBirthDay_ext {
    public Candidate_Birthday__c cb{get;set;}
    
    public CanBirthDay_ext(ApexPages.StandardController controller) {
        cb = new Candidate_Birthday__c();
    }
    public CanBirthDay_ext() {}
    
    public pageReference Save() {
    
        Candidate_Birthday__c cbs = new Candidate_Birthday__c();
        cbs.Name = cb.Name;
        cbs.Date_Of_Birth__c = cb.Date_Of_Birth__c;
        cbs.Candidate_Email__c = cb.Candidate_Email__c;
        cbs.Mobile_No__c = cb.Mobile_No__c;
        cbs.Event_Type__c = cb.Event_Type__c;
        insert cbs;
        
        Pagereference newpage = new Pagereference('/Apex/Thank_You');
        return newpage;
    }
}