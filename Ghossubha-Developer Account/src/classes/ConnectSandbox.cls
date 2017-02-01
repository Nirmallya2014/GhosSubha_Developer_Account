public class ConnectSandbox {
   public String clientId {get; set;} //= '3MVG9ZL0ppGP5UrBmK0Nmry63398pH4iPmIqgSTQ8FTgoD4U5pLhA2CT9yEgAeVmQ2DNg2ifrA91IHSd8ZAjv';
   public String clientSecret {get; set;} //= '3501799042714180977';
   public String username {get; set;} //= 'nirmallya2014@gmail.com';
   public String password {get; set;} //= 'India@2006';
   
   public class deserializeResponse
   {
      public String id;
      public String access_token;
   }
   public String ReturnAccessToken ()
   {
      String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
      req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
      HttpResponse res = h.send(req);
      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Access Token'+resp1.access_token));
      return resp1.access_token;
   }
   
   public void connectSandbox()
   {
   	  try {
			  ConnectSandbox getToken = new ConnectSandbox();
			  String accessToken;
			  accessToken = getToken.ReturnAccessToken();
			  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Access Token'+accessToken));
			  system.debug('@Access Token@'+accessToken);
   	  }catch(Exception ex) {
   	  		  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
   	  		  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Error is-'+ex.getLineNumber()));
   	  		  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Error is-'+ex.getCause()));
   	  }
   }
}