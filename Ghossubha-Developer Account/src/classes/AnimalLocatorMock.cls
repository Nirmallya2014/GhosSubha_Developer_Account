@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        System.assertEquals('https://th-apex-http-callout.herokuapp.com/animals/1', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"animal":{"id":2,"name":"bear","eats":"berries, campers, adam seligman","says":"yum yum"}}');    
        res.setStatusCode(200);
        return res;
    }
}