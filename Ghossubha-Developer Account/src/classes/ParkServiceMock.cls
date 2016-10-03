@isTest
global class ParkServiceMock implements WebServiceMock{
    // Implement this interface method
    global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        List<String> responseString = new List<String>();
        responseString.Add('A');
        responseString.Add('B');
        responseString.Add('C');
        ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
        response_x.return_x = responseString;
        // end
        response.put('response_x', response_x); 
   }
}