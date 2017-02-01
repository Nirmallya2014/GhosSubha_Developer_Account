@RestResource(urlMapping='/Cases/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
    	system.debug('New Class Addition 2');
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account act = [select id, name from account where Id =: accountId];
        return act;
    }
}