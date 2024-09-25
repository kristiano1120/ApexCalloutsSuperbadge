global class AccessibilityProjectBilling{
     @future(callout=true)
     public static void callBillingService(String projectId, Decimal billingAmount){
          
          try {
               //Setup username, password, billAmount, and projectid in BillingServiceProxy.project and then call billProject method
               BillingServiceProxy.project project = new BillingServiceProxy.project();
               project.username = '{!$Credential.BillingServiceCredential.username}';
               project.password = '{!$Credential.BillingServiceCredential.password}';
               project.billAmount = billingAmount;
               project.projectid = projectId;
               System.debug('username: ' + project.userName);          
               BillingServiceProxy.InvoicesPortSoap11 service = new BillingServiceProxy.InvoicesPortSoap11();
               String response = service.billProject(project);
               //If response is ok set Accessibility Project Status = Complete
               if (response == 'ok') { 
                    Accessibility_Project__c accP = [SELECT Id, Status__c FROM Accessibility_Project__c WHERE Id =: projectId];
                    accP.Status__c = 'Complete';
                    update accP;
                    System.debug('Estado del proyecto actualizado a "Complete". Estado: ' + response);
               } else {
                    System.debug('Error en SOAP Callout, Estado: ' + response);
               }
          } catch (Exception e) {
               System.debug('Error en SOAP Callout, Mensaje: ' + e.getMessage());               
          }      
     }
}