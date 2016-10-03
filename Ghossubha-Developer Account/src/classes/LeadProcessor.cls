global class LeadProcessor implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        String soql = 'select id, LeadSource from Lead';
        return Database.getQueryLocator(soql);
    }

    global void execute(Database.BatchableContext bc, List<Lead> listlead){
        For(Lead ld : listLead) {
            ld.LeadSource = 'Dreamforce';
        }
        Database.Update(listLead);
    }    

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    

}