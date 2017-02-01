public class AccountHandler {
    
    public AccountHandler() {
        Account a = insertNewAccount('India Natural 222');
        Account ac = insertNewAccount(null);
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