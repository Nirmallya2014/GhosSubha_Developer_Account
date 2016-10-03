public with sharing class AnimalLocator{
    
    public static Map<String, String> webserviceInfo{get; set;} 
    public static string getAnimalNameById(Integer animalInfo) {
        String animalName;
        webserviceInfo = new Map<String, String>();       
        String endPointUrl = 'https://th-apex-http-callout.herokuapp.com/animals/';
        String finalUrl = endPointUrl+animalInfo;  
        System.debug('@-----NirmallyaFinal Url------------------@@'+finalUrl);
        Http htp = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(finalUrl);
        req.setMethod('GET');
        req.setTimeout(120000);
       
        HttpResponse httpres = htp.send(req);
        system.debug('@Response@'+httpres.getBody());
        
        JSONParser parser = JSON.createParser(httpres.getBody());
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while(parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                        String fieldName = parser.getText();
                        parser.nextToken();
                        webserviceInfo.put(fieldName, parser.getText());
                        if(fieldName == 'name') {
                            system.debug('@Animal Name@'+parser.getText());
                            animalName = parser.getText();
                        }
                    }
                }
                system.debug('Hello World');
            }
            if(parser.getCurrentToken() == JSONToken.START_OBJECT) {
                while(parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                        String fieldName = parser.getText();
                        parser.nextToken();
                        if(fieldName == 'name') {
                            animalName = parser.getText();
                            system.debug('@Animal Name@'+parser.getText());
                        }
                        webserviceInfo.put(fieldName, parser.getText());
                    }
                }
            }
        }  
        system.debug('@Details@'+webserviceInfo);  
        return animalName;      
    }
}