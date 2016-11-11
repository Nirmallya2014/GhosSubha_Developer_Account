public class SampleSOAPCall {
    public String createSOAPHeaderRequest() {
        String requestHeaderBody = '<soapenv:Envelope xmlns:par="http://www.ibm.com/mdm/port/Party" xmlns:sch="http://www.ibm.com/mdm/schema"'+
                              'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">'+
                                '<soapenv:Header>'+
                                    '<wsse:Security soapenv:mustUnderstand="1" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"'+
                                    'xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">'+
                                    '<wsse:UsernameToken wsu:Id="UsernameToken-232165D52B5B27E68814743062964631">'+
                                    '<wsse:Username>uid=wasadmin,o=defaultWIMFileBasedRealm</wsse:Username>'+
                                    '<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">jVIftEj</wsse:Password>'+
                                    '<wsse:Nonce EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary">QyaAdoH52wqBt1Uw2WGU2w==</wsse:Nonce>'+
                                    '<wsu:Created>2016-09-19T17:31:36.462Z</wsu:Created>'+
                                    '</wsse:UsernameToken>'+
                                    '</wsse:Security>'+
                                '</soapenv:Header>';
        return requestHeaderBody;
    }
  
    public String createSOAPBody() {
        String requestBodyElement = '<soapenv:Body>'+
                                    '<par:maintainManulifePartyContactMethod>'+
                                    '<sch:RequestControl>'+
                                        '<sch:requestID>123456</sch:requestID>'+
                                        '<sch:DWLControl>'+
                                            '<sch:requesterName>cusadmin</sch:requesterName>'+
                                            '<sch:requesterLanguage>100</sch:requesterLanguage>'+
                                        '</sch:DWLControl>'+
                                    '</sch:RequestControl>'+
                                    '<sch:TCRMPartyBObj>'+
                                        '<sch:PartyId>238947262482528001</sch:PartyId>'+
                                        '<sch:SourceIdentifierType>14</sch:SourceIdentifierType>'+
                                        '<sch:TCRMPartyContactMethodBObj>'+
                                            '<sch:ContactMethodUsageType>13</sch:ContactMethodUsageType>'+
                                            '<sch:ContactMethodStatusType>1</sch:ContactMethodStatusType>'+
                                            '<sch:TCRMContactMethodBObj>'+
                                              '<sch:ReferenceNumber>john.oldenburg@gmail.com</sch:ReferenceNumber>'+
                                            '</sch:TCRMContactMethodBObj>'+
                                            '</sch:TCRMPartyContactMethodBObj>'+
                                    '</sch:TCRMPartyBObj>'+
                                    '</par:maintainManulifePartyContactMethod>'+
                                    '</soapenv:Body>'+
                                    '</soapenv:Envelope>';
        return requestBodyElement;
    }
    
    public void invokeUpdateContactMDMMethod() {
        try {
            String soapBody = createSOAPHeaderRequest() + createSOAPBody();
            apexpages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, soapBody));
            Http httpCall = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('http://dmdev1mdm1.manulife.com:10119/MDMWSProvider/MDMService'); 
            request.setMethod('POST');
            request.setTimeout(120000);
            request.setBody(soapBody);
            HTTPResponse res = httpCall.send(request);
            system.debug(LoggingLevel.Info, res.getBody());
            apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, res.getBody()));
        }
        catch(Exception ex) {
            system.debug(LoggingLevel.Info, ex.getMessage());
            apexpages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, ex.getMessage()));
        }
    }
}