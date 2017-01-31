public class AccountHandler {
    
    public AccountHandler() {
        Account a = insertNewAccount('Test Account 122');
        Account ac = insertNewAccount(null);
        system.debug('New Changes Test 1');
        system.debug('New Changes Test 2');
        system.debug('New Changes Test 3');
    }
    public static Account insertNewAccount(string accountName) {
        try {
            Account ac = new Account();
            ac.name = accountName;
            insert ac;
            return ac;
        }catch(exception ex) {
            return null;
        }
    }
}