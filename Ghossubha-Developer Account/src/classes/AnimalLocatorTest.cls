@isTest
global with sharing class AnimalLocatorTest{

    static testMethod void AnimalLocatorTestMethod1() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        AnimalLocator.getAnimalNameById(1);
    }
}