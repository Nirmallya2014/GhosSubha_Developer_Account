public class AccountHandler {
    
    public AccountHandler() {
        Account a = insertNewAccount('Nirmallya Ghosh');
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
    
    public static void updateAccount() {
    	
    }
}