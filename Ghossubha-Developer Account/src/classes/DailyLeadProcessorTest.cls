@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @testSetup
    static void createTestData() {
        List<Lead> ldeList = new List<Lead>();
        // add 200 child accounts
        for (Integer i = 0; i < 200; i++) {
            ldeList.add(new Lead(
                LastName = 'Test Account'+i,
                Company = 'CTS',
                Status = 'Open - Not Contacted'
            ));
        }
        insert ldeList;
    }
    
    static testMethod void DailyLeadProcessorMethod() {
        String jobId = System.schedule('DailyLeadProcessor',
            CRON_EXP, 
            new DailyLeadProcessor()); 
    }
}