public class AccountHandler {
    
    public AccountHandler() {
        Account a = insertNewAccount('Test Account');
        Account ac = insertNewAccount(null);
        system.debug('India is Great 22');
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