@isTest
public class Vitality_RegistrationRequestContTest {
    
    public static Membership__c mship {get; set;}
    
    public static void createTestData(string policyStatus, string policyNumber, string userEmail, boolean needEndpointURL) {
        User usr = Vitality_TestDataUtility.createUser('en_US', 'portalUser@testorg.com', 'portalUser@testorg.com');
        insert usr;
        system.runAs(usr) {
            Account acc = Vitality_TestDataUtility.createAccount();
            insert acc;
            acc.OwnerId = usr.Id;
            update acc;
            Contact con = Vitality_TestDataUtility.createContact(userEmail, acc);
			insert con;
			mship = Vitality_TestDataUtility.createMembershipRecord(con, policyNumber, policyStatus);
            insert mship;
            Vitality_TestDataUtility.createCustomSettings(needEndpointURL);
        }
    }
    
    public static Map<string, string> checkAndValidateMemberShipData(boolean memberFound) {
        Map<string, string> memInfoMap = new Map<string, string>();
        memInfoMap.put('lastName', 'User00');
        if(memberFound) {
            memInfoMap.put('email', 'testuserInfo00@test.com');
        }else {
            memInfoMap.put('email', 'testuser@test.com');
        }
        memInfoMap.put('dateOfBirth', '1990-7-5');
        memInfoMap.put('policyNumber', '123654');
        system.debug('@Map Info@'+memInfoMap);
        Map<string, string> returnMsg = Vitality_RegistrationRequestController.checkContactExist(memInfoMap);
        return returnMsg;
    }
    
    public static testMethod void TestHandleTranslationForBothLanguage() {
        ApexPages.currentPage().getParameters().put('langCode', 'en');
        Vitality_RegistrationRequestController resetResult = new Vitality_RegistrationRequestController();
        resetResult.handleTranslation();
        ApexPages.currentPage().getParameters().put('langCode', 'fr');
        Vitality_RegistrationRequestController resetResult1 = new Vitality_RegistrationRequestController();
        resetResult1.handleTranslation();
    }
    
    public static testMethod void validateMemberShipDataPolicyTerminated() {
        //Arrange
        createTestData('Terminated', '123654', 'testuserInfo00@test.com', True);
        //Act
        Map<string, string> returnMsg = checkAndValidateMemberShipData(true);
        //Assert
        system.assertEquals('error', returnMsg.get('status'));
    }
    
    
    public static testMethod void validateMemberShipDataSuccess() {
        //Arrange
        createTestData('Active', '123654', 'testuserInfo00@test.com', True);
        //Act
        Map<string, string> returnMsg = checkAndValidateMemberShipData(true);
        //Assert
        system.assertEquals('success', returnMsg.get('status'));
    }
    
    public static testMethod void validateMemberShipDataNoStatusError() {
        //Arrange
        createTestData('TEST', '123654', 'testuserInfo00@test.com', True);
        //Act
        Map<string, string> returnMsg = checkAndValidateMemberShipData(true);
        //Assert
        system.assertEquals('error', returnMsg.get('status'));
    }
    
    public static testMethod void validateMemberShipDataPolicyError() {
        //Arrange
        createTestData('Active', '123654', 'testuser1@test.com', True);
        //Act
        Map<string, string> returnMsg = checkAndValidateMemberShipData(false);
        //Assert
        system.assertEquals('error', returnMsg.get('status'));
    }
    
    public static testMethod void validateChangePasswordSuccess() {
        //Arrange 
        createTestData('Active', '123654', 'testuser00@test.com', True);
        
        //Act
        Map<String, string> isamRequest = new Map<String, string>();
        isamRequest.put('urlIdVal', mship.id);
        isamRequest.put('password', 'Abcd1234');
        isamRequest.put('langCode', 'en_US');
        Test.startTest();
        Vitality_MockHttpResponseGenerator.respStatus = 'true';
        Vitality_MockHttpResponseGenerator.respCode = 200;
        Test.setMock(HttpCalloutMock.class, new Vitality_MockHttpResponseGenerator());
        Map<string, string> returnMsgSuccess = Vitality_RegistrationRequestController.createAccount(isamRequest);
        Test.stopTest();
        
        //Assert
        system.assertEquals('success', returnMsgSuccess.get('status'));
    }
    public static testMethod void validateChangePasswordSuccess_fr_CA() {
        //Arrange 
        createTestData('Active', '123654', 'testuser00@test.com', True);
        
        //Act
        Map<String, string> isamRequest = new Map<String, string>();
        isamRequest.put('urlIdVal', mship.id);
        isamRequest.put('password', 'Abcd1234');
        isamRequest.put('langCode', 'fr_CA');
        Test.startTest();
        Vitality_MockHttpResponseGenerator.respStatus = 'true';
        Vitality_MockHttpResponseGenerator.respCode = 200;
        Test.setMock(HttpCalloutMock.class, new Vitality_MockHttpResponseGenerator());
        Map<string, string> returnMsgSuccess = Vitality_RegistrationRequestController.createAccount(isamRequest);
        Test.stopTest();
        
        //Assert
        system.assertEquals('success', returnMsgSuccess.get('status'));
    }
    
    public static testMethod void validateChangePasswordSuccessExixtingUser() {
        //Arrange 
        createTestData('Active', '123654', 'testuser00@test.com', True);
        
        //Act
        Map<String, string> isamRequest = new Map<String, string>();
        isamRequest.put('urlIdVal', mship.id);
        isamRequest.put('password', 'Abcd1234');
        isamRequest.put('langCode', 'fr_CA');
        
        //Creating user  
        Profile prof = [SELECT Id FROM Profile WHERE Name='Customer Community Login User' limit 1];
        if(prof != Null){
            User testUser= new User(CommunityNickname= 'testuser00', Email = 'testuser00@test.com', Alias = 'testAl', Username = 'testuser00@test.com' , ContactId = mship.member__c, LastName = 'testLastName', IsActive = true, ProfileId = prof.Id, EmailEncodingKey = 'UTF-8', LocaleSidKey = 'fr_CA', LanguageLocaleKey = 'en_US', TimeZoneSidKey = 'GMT' );
            insert testUser;
        }
        
        Test.startTest();
        Vitality_MockHttpResponseGenerator.respStatus = 'true';
        Vitality_MockHttpResponseGenerator.respCode = 200;
        Test.setMock(HttpCalloutMock.class, new Vitality_MockHttpResponseGenerator());
        Map<string, string> returnMsgSuccess = Vitality_RegistrationRequestController.createAccount(isamRequest);
        Test.stopTest();
        
        //Assert
        system.assertEquals('success',returnMsgSuccess.get('status'));
    }
    
    public static testMethod void validateChangePasswordSuccessFalse() {
        //Arrange 
        createTestData('Active', '123654', 'testuser00@test.com', True);
        
        //Act
        Map<String, string> isamRequest = new Map<String, string>();
        isamRequest.put('urlIdVal', mship.id);
        isamRequest.put('password', 'Abcd1234');
        isamRequest.put('langCode', 'fr_CA');
        Test.startTest();
        Vitality_MockHttpResponseGenerator.respStatus = 'false';
        Vitality_MockHttpResponseGenerator.respCode = 200;
        Test.setMock(HttpCalloutMock.class, new Vitality_MockHttpResponseGenerator());
        Map<string, string> returnMsgSuccess = Vitality_RegistrationRequestController.createAccount(isamRequest);
        Test.stopTest();
        
        //Assert
        system.assertEquals('error',returnMsgSuccess.get('status'));
    }
    
    
    public static testMethod void validateChangePasswordResp500() {
        //Arrange 
        createTestData('Active', '123654', 'testuser00@test.com', True);
        
        //Act
        Map<String, string> isamRequest = new Map<String, string>();
        isamRequest.put('urlIdVal', mship.id);
        isamRequest.put('password', 'Abcd1234');
        isamRequest.put('langCode', 'fr_CA');
        Test.startTest();
        Vitality_MockHttpResponseGenerator.respStatus = 'NA';
        Vitality_MockHttpResponseGenerator.respCode = 500;
        Test.setMock(HttpCalloutMock.class, new Vitality_MockHttpResponseGenerator());
        Map<string, string> returnMsgSuccess = Vitality_RegistrationRequestController.createAccount(isamRequest);
        Test.stopTest();
        
        //Assert
        system.assertEquals('error',returnMsgSuccess.get('status'));
    }
    
    
    public static testMethod void validateChangePasswordSuccessNoUserRole() {
        //Arrange 
        createTestData('Active', '123654', 'testuser00@test.com', True);
        
        //Act
        Map<String, string> isamRequest = new Map<String, string>();
        isamRequest.put('urlIdVal', mship.id);
        isamRequest.put('password', 'Abcd1234');
        isamRequest.put('langCode', 'en_US');
        
        Membership__c memberRecord  = [select id, name, member__r.AccountId from Membership__c where ID =: mship.id limit 1] ;
        if(memberRecord != null) {
            Account accInfo = [select OwnerId from account where id =: memberRecord.member__r.AccountId];
            User usr = [select UserRoleId from User where id =: accInfo.OwnerId];
            if(usr != null) {
                usr.UserRoleId = Null;
                update usr;
            }
        }
        
        Test.startTest();
        Vitality_MockHttpResponseGenerator.respStatus = 'NA';
        Vitality_MockHttpResponseGenerator.respCode = 200;
        Test.setMock(HttpCalloutMock.class, new Vitality_MockHttpResponseGenerator());
        Map<string, string> returnMsgSuccess = Vitality_RegistrationRequestController.createAccount(isamRequest);
        Test.stopTest();
        
        //Assert
        system.assertEquals('error',returnMsgSuccess.get('status'));
    }
    public static testMethod void testException() {
        //Arrange 
        createTestData('Active', '123654', 'testuser00@test.com', False);
        //Act
        Map<String, string> isamRequest = new Map<String, string>();
        
        isamRequest.put('urlIdVal', mship.id);
        isamRequest.put('password', 'Abcd1234');
        isamRequest.put('langCode', 'fr_CA');
        
        Test.startTest();
        Map<string, string> returnMsgSuccess = Vitality_RegistrationRequestController.createAccount(isamRequest);
        Test.stopTest();
        
        //Assert
        system.assertEquals('error',returnMsgSuccess.get('status'));
    }
}