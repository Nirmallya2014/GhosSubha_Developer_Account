/**
 * Name: Vitality_TestDataUtility.cls
 * Purpose: The purpose of the is to provide the generic methods for test data creation
 * This class returns the generic instance of various objects and returns them to test class for unit test creation
 */
@istest
public class Vitality_TestDataUtility {
	
    public static User createUser(String userLocale, String userEmail, String userName) {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        UserRole usrrole = [SELECT Id, Name FROM UserRole where Name = 'System Administrator'];
        User usr = new User(Alias = 'portalu', Email = userEmail, 
                            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey=userLocale, 
                            LocaleSidKey='en_US', ProfileId = p.Id, UserRoleId = usrrole.Id,
                            TimeZoneSidKey='America/Los_Angeles', UserName = userName);
        return usr;
    }
    
    public static Account createAccount() {
        Account acc = new Account();
        acc.Name = 'Test Account';
        return acc;
    }
    
    public static Contact createContact(String userEmail, Account acc) {
        Contact con = new Contact();
        con.FirstName = 'Test000';
        con.LastName = 'User00';
        con.Vitality_DOB__c = getEncryptedDob();
        con.Email = userEmail;
        con.AccountId = acc.Id;
        con.PortalRegistrationID__c = '123654';
        return con;
    }
    
    public static Membership__c createMembershipRecord(Contact con, String policyNumber, String policyStatus) {
        Membership__c mship = new Membership__c();
        mship.Member__c = con.Id;
        mship.MembershipID__c = policyNumber;
        mship.Status__c = policyStatus;
        mship.Type__c = 'Vitality';
        return mship;
    }
    
    Public Static void createCustomSettings(boolean needEndpointURL) {
        IntegrationEndpoints__c endPoints = new IntegrationEndpoints__c();
        endPoints.Name = 'Registration';
        if(needEndpointURL){
            endPoints.EndpointUrl__c = 'http://169.53.166.248/sdi/';
        }
        endPoints.IntegrationName__c = 'Registration';
        insert endPoints;
    }
    
    public static string getEncryptedDob() {
        Date mydate = Date.parse('7/5/1990');
        String newDob = mydate.month() + '/' + mydate.day() + '/' + mydate.year();
        String inputEncryption = newDob + userinfo.getOrganizationId();
        Blob b = Crypto.generateDigest('SHA-256', Blob.valueOf(inputEncryption));
        String encryptedDob = EncodingUtil.base64Encode(b);
        return encryptedDob;
    }
}