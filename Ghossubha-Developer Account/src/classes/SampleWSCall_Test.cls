@isTest
global with sharing class SampleWSCall_Test{

    static testMethod void WSCall_Test_Method1() {
    
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Test_Field__c = 'test';
        insert acc;
    
        Contact con = new Contact();
        con.LastName = 'Test1';
        con.Email = 'test@gmail.com';
        con.AccountId = acc.Id;
        con.portalregistrationid__c = '145255';
        con.DateOfBirth__c = '11/06/1990';
        insert con;   
        
        String requestBody = CCT_FutureMdmServiceCallout.prepareJsonRequest(con);
        String externalId = 'Mem101';
        String partyID = externalId.substring(3, externalId.length());
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
        CCT_FutureMdmServiceCallout.doCallOut(con.Id, requestBody, partyID, 'en');
    }
    
}