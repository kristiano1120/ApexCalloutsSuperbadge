public class RewardsCalloutService{

    public static Integer submitUsersForRewardCallout(String jsonBody) {
        //Set Endpoint from Named Credential
        String endpoint = 'callout:IntegrationSB__BalancedLiving/rewards';
        
        //Make HTTP Callout
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonBody);
        
        Http http = new http();
        HttpResponse res;

        //Update to return response status code
        res = http.send(req);
        return res.getStatusCode();
    }
}