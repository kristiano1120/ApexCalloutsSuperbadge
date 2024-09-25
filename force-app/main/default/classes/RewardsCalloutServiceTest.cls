@isTest
public with sharing class RewardsCalloutServiceTest {
    
    @IsTest
    static void rewardsCalloutService(){
        String jsonBody = 'jsonBody';
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        Integer res = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
        
        Integer statusCode = res;        

        System.assertEquals(201, statusCode);        
        
    }
}