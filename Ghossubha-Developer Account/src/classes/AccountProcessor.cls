public class AccountProcessor {
    @future
    public static void countContacts(Set<Id> accountIds) {
        List<Account> listAccount = new List<Account>();
        Map<Id, Id> mapNoOfContact = new Map<Id, Id>();
        if(accountIds.size() > 0) {
        	System.debug('new Changes');
        	System.debug('Debug Changes 2');
        	
        	System.debug('Debug Changes After Build Success 1');
        	System.debug('Debug Changes After Build Success 2');
            List<Account> lstAccount = [select id, (select id from contacts) from account where id in :accountIds];
            for(Account acc : lstAccount ) {
                List<Contact> lstCont = acc.contacts ;
                //acc.Number_of_Contacts__c = lstCont.size();
            }
            update lstAccount;
        }
    }
}