@isTest
public with sharing class BillingCalloutServiceTest {
    @TestSetup
    static void makeData(){
        Workshop__c ws = new Workshop__c(
            Name = 'New Workshop 3', 
            DHH_Accessible__c = true,
            Date__c = Date.today()
            );
        insert ws;
        
        Accessibility_Project__c ap = new Accessibility_Project__c(
            Amount__c = 100, 
            Type__c = 'Sign Language Interpreters', 
            Status__c = 'Submitted'
        );
        insert ap;
    }

    @IsTest
    static void billingCalloutSeviceTest(){
        BillingCalloutServiceMock mock = new BillingCalloutServiceMock();
        Test.setMock(WebServiceMock.class, mock);

        Accessibility_Project__c ap = [SELECT Id, Status__c, Amount__c FROM Accessibility_Project__c WHERE Status__c = 'Submitted' LIMIT 1];
        Test.startTest();
        AccessibilityProjectBilling.callBillingService(ap.Id, ap.Amount__c);
        Test.stopTest();
        
        
        Accessibility_Project__c apu = [SELECT Id, Status__c, Amount__c FROM Accessibility_Project__c WHERE Id =: ap.Id];
        System.assertEquals('Complete', apu.Status__c);
    }
}