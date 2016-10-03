@isTest
private class MixedDML {
    
    @future
    public static void insertUserWithRole(
        String uname, String lname) {

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT Id FROM UserRole WHERE Name='COO'];
        // Create new user with a non-null user role ID 
        User u = new User(alias = 'al', email='em@test.co', 
            emailencodingkey='UTF-8', lastname=lname, 
            languagelocalekey='en_US', 
            localesidkey='en_US',
            timezonesidkey='America/Los_Angeles', profileid = p.Id, userroleid = r.Id,
            username=uname);
        insert u;
    }
    
    static testMethod void useFutureMethod() {
        // This next operation (insert a user with a role) 
        // can't be mixed with the previous insert unless 
        // it is within a future method. 
        // Call future method to insert a user with a role.
        insertUserWithRole(
            'mruiz112@awcomputing.com', 'mruiz');       
            
        Account a = new Account(Name='Acme');
        insert a; 
    }
}