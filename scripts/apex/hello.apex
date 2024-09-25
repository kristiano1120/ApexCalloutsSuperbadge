// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
Database.executeBatch(batch, 200);


List<Map<String, Object>> usersListMap = new List<Map<String, Object>>();
Map<String, Object> userObj = new Map<String, Object>();    
    
//Build JSON object                    
userObj.put('userId','1k2kj29292h3n3i');
userObj.put('fullName','Cristian Camilo Osorio');
userObj.put('email','prueba@mail.com');
userObj.put('username','User Owner Name');

//Add to array
usersListMap.add(userObj);

String jsonBody = JSON.serialize(usersListMap);
System.debug('Jsonbody: ' + jsonBody);

Integer responseCode = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);

// Crear una instancia de la clase batch
WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();

// Ejecutar el batch con un tamaño de lote específico (por ejemplo, 200 registros por lote)
Database.executeBatch(batch, 100);

List<Map<String, Object>> usersListMap = new List<Map<String, Object>>();
Map<String, Object> userObj = new Map<String, Object>();


List<Wellness_Journey__c> wjrs = [SELECT Id, Name, OwnerId, Owner.Name, Owner.Email, Owner.Username 
                                    FROM Wellness_Journey__c 
                                    WHERE Status__c = 'Complete' 
                                    AND Completion_Date__c >= 2024-09-01T00:00:00Z 
                                    AND Completion_Date__c <= 2024-12-01T00:00:00Z 
                                    ORDER BY OwnerId, Completion_Date__c];

for (Wellness_Journey__c wjr : wjrs) {
    userObj.put('userId', wjr.OwnerId);
    userObj.put('fullName', wjr.owner.Name);
    userObj.put('email', wjr.Owner.Email);
    userObj.put('username', wjr.Owner.Username);

    usersListMap.add(userObj);
}
String jsonBody = JSON.serialize(usersListMap);
System.debug('jsonBody: ' + jsonBody);

//Invoke Callout
Integer responseCode = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
System.debug('HTTP Response Code: ' + responseCode); 
System.debug('response: ' + responseCode);

Workshop__c ws = new Workshop__c(Name = 'New Workshop 3', DHH_Accessible__c = true);
insert ws;

Accessibility_Project__c ap = new Accessibility_Project__c(
            Amount__c = 100, 
            Type__c = 'Sign Language Interpreters', 
            Status__c = 'Submitted'
        );
        insert ap;