public class findSmithAccounts {
    private final List<Account> accounts;

    public findSmithAccounts() {
        accounts = [select Name from Account];
    }

    public List<Account> getSmithAccounts() {
        return accounts;
    }
}