Public class JSONParseClass {
    Public JSONParseClass() {
        
    }
    public static void parseJSONString() {
        String jsonStr = 
            '{"invoiceList":[' +
            '{"totalPrice":5.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[' +
            '{"UnitPrice":1.0,"Quantity":5.0,"ProductName":"Pencil"},' +
            '{"UnitPrice":0.5,"Quantity":1.0,"ProductName":"Eraser"}],' +
            '"invoiceNumber":1},' +
            '{"totalPrice":11.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[' +
            '{"UnitPrice":6.0,"Quantity":1.0,"ProductName":"Notebook"},' +
            '{"UnitPrice":2.5,"Quantity":1.0,"ProductName":"Ruler"},' +
            '{"UnitPrice":1.5,"Quantity":2.0,"ProductName":"Pen"}],"invoiceNumber":2}' +
            ']}';
        JSONParser parser = JSON.createParser(jsonStr);
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while(parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                        String fieldName = parser.getText();
                        parser.nextToken();
                        if(fieldName == 'totalPrice') {
                            system.debug('@totalPrice 2@'+parser.getText());
                        } else if(fieldName == 'statementDate') {
                            system.debug('@statementDate 2@'+parser.getText());
                        }
                    }
                }
            }
            if(parser.getCurrentToken() == JSONToken.START_OBJECT) {
                while(parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                        String fieldName = parser.getText();
                        parser.nextToken();
                        if(fieldName == 'totalPrice') {
                            system.debug('@totalPrice@'+parser.getText());
                        } else if(fieldName == 'statementDate') {
                            system.debug('@statementDate@'+parser.getText());
                        }
                    }
                }
            }
        }
    }
}