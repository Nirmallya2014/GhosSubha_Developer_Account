@RestResource(urlMapping='/Cases/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account act = [select id, name from account where Id =: accountId];
        return act;
    }
    
   
    global static Account putAccount() {
    	system.debug('New Class Addition');
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account act = [select id, name from account where Id =: accountId];
        return act;
    }
}