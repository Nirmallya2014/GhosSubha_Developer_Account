@isTest
public class TestClass_testOwnerClass {
    
    static testmethod void testWithTestClassOwner() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser111@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser111@testorg.com');
        insert u;
        system.debug('User Id'+u.Id);
        System.runAs(u) {
            Case testCase = new Case();
            testCase.Status='New';
            testCase.Origin = 'Phone';
            testCase.OwnerId = u.Id;
            insert testCase;
            system.debug('Test Case Number Is'+testCase.Id);
            TestOwnerClass testOwner = new TestOwnerClass();
            PageReference myVfPage = Page.TestPage;
            Test.setCurrentPage(myVfPage);
            ApexPages.currentPage().getParameters().put('caseId', testCase.Id);
            TestOwner.updateCase();
            system.debug('Test Case Owner Is'+testCase.OwnerId);
            
            system.assertEquals(testCase.UpdateCase__c, false);
        }
    }
    
    static testmethod void testWithStandardOwner() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser111@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser111@testorg.com');
        insert u;
        system.debug('User Id2--'+u.Id);
        Case testCase;
        System.runAs(u) {
            testCase = new Case();
            testCase.Status='New';
            testCase.Origin = 'Phone';
            testCase.OwnerId = u.Id;
            insert testCase;
        }
        TestOwnerClass testOwner = new TestOwnerClass();
        PageReference myVfPage = Page.TestPage;
        Test.setCurrentPage(myVfPage);
        ApexPages.currentPage().getParameters().put('caseId', testCase.Id);
        TestOwner.updateCase();
        system.debug('Test Case Owner Is2--'+testCase.OwnerId);
        system.assertEquals(testCase.UpdateCase__c, true);
    }
}