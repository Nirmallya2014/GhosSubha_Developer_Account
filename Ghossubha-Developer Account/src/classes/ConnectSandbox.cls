public class ConnectSandbox {
   public String clientId {get; set;} //= '3MVG9Y6d_Btp4xp4UfGzxUDo3wF0ASm3PfkYi9_TISOuAGMojvTC7ZNA9ABIWqtGaRjvzWwKV7AsF28L8Lahv';
   public String clientSecret {get; set;} //= '6422426981885505017';
   public String username {get; set;} //= 'nghosh@gmail.com';
   public String password {get; set;} //= 'Kolkata2006';
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
      return resp1.access_token;
   }
   
   public void connectSandbox()
   {
      ConnectSandbox getToken = new ConnectSandbox();
      String accessToken;
      accessToken = getToken.ReturnAccessToken();
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Connection established'));
      system.debug('@Access Token@'+accessToken);
   }
}