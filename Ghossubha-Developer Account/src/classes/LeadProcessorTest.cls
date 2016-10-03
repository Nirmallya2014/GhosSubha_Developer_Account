@isTest
public class LeadProcessorTest {
    @testSetup
    public static void CreateTestData() {
        List<Lead> bulkLead = new List<Lead>();
        For(integer i = 0; i < 200; i++) {
            Lead lde = new Lead();
            lde.LastName = 'Test lead-'+i;
            lde.Company = 'CTS-'+i;
            lde.Status = 'Working - Contacted';
            bulkLead.add(lde);
        }
        Database.Insert(bulkLead);
    }
    
    static testMethod void TestBatch() {
        Test.StartTest();
            LeadProcessor lp = new LeadProcessor();
            Id batchId = Database.executeBatch(lp);
        Test.StopTest();
    }
}