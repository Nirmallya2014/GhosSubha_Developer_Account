global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> updatedLead = new List<Lead>();
        List<Lead> ldeList = [Select Id, LeadSource From Lead LIMIT 200];
        For(Lead ld : ldeList) {
            ld.LeadSource = 'Dreamforce';
            updatedLead.add(ld);
        }
        Database.Update(ldeList);
    }
}