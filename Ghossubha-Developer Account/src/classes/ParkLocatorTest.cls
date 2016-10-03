@isTest
public class ParkLocatorTest{
    static testMethod void TestMethod1() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        ParkLocator.Country('India');
    }
}