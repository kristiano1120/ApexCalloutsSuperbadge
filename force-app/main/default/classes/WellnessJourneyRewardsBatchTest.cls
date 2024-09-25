@IsTest
public with sharing class WellnessJourneyRewardsBatchTest {
    @TestSetup
    static void makeData(){

        Profile p = [SELECT Id FROM Profile WHERE Name = 'Usuario de Platform estándar' LIMIT 1];
        User u = new User();
        u.LastName = 'Test';
        u.FirstName = 'User';
        u.Alias = 'tsuert';
        u.Email = 'testuser@mail.com';
        u.Username = 'testuserintespecialist@mailprueba.com';
        u.ProfileId = p.Id;
        u.TimeZoneSidKey = 'America/New_York';
        u.LocaleSidKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        insert u;
        

        List<Wellness_Journey__c> wjr = new List<Wellness_Journey__c>();
        for (Integer i = 0; i < 12; i++) {
            Datetime compDate = Datetime.newInstance(2024, 9, 10, 00, 00, 00);
            Wellness_Journey__c wj = new Wellness_Journey__c();
            wj.Name = 'WellnessJourneyTest' + i;
            wj.OwnerId = u.Id;
            wj.Status__c = 'Complete';
            wj.Completion_Date__c = compDate;
            wjr.add(wj);
        }
        insert wjr;
    }

    @IsTest
    static void WellnessJourneyBatch(){
        
        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        List<Wellness_Journey__c> processedJourneys = [SELECT Id FROM Wellness_Journey__c WHERE Status__c = 'Complete'];
        System.assertEquals(12, processedJourneys.size());
        
    }

    @IsTest
    static void WellnessJourneyBatchCallout(){    
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

        List<Wellness_Journey__c> wjrs = [SELECT Id, Name, Completion_Goal__c, Completion_Date__c, OwnerId, Owner.Email, 
                                        Owner.Username, Owner.Name                             
                                        FROM Wellness_Journey__c WHERE Status__c = 'Complete'];

        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        batch.execute(null, wjrs);
        Test.stopTest();
        System.assertEquals(12, wjrs.size());
        
    }
}