@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://www.google.com/test101/contactmethods/VitalityEmail', req.getEndpoint());
        System.assertEquals('PUT', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"firstName":"John"}');    
        res.setStatusCode(200);
        return res;
    }
}