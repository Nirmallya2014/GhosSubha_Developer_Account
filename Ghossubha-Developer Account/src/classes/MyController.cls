public with sharing class MyController {

    public String language {get;set;}
    public String lblValue {get; set;}
    public PageReference toFrench() {
        language = 'fr';
        lblValue = Label.TestString;
        return null;
    }

    public PageReference toEnglish() {
        language = 'en_US';
        lblValue = Label.TestString;
        return null;
    }

    public MyController() {
        toEnglish();
    }
}