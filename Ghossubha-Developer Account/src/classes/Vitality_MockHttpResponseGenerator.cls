@isTest
global class Vitality_MockHttpResponseGenerator implements HttpCalloutMock{
    global static string respStatus {get;set;}
    global static Integer respCode {get;set;}
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('http://169.53.166.248/sdi/', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        //res.setBody('{"success":"true"}');    
        res.setBody('{"success":"'+respStatus+'"}');    
        res.setStatusCode(respCode);
        return res;
    }
}