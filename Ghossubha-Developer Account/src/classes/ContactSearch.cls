global with sharing class ContactSearch {
    
    webservice static List<Contact> searchForContacts(string lastname, string mailingPostalCode) {

        List<contact> conList = [select id, lastname, mailingPostalCode from Contact where lastName =: lastname AND mailingPostalCode =: MailingPostalCode];
        return conList;
    }
}