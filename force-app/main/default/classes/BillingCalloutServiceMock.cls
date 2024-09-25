global with sharing class BillingCalloutServiceMock implements WebServiceMock{
    global void doInvoke(
        Object stub, 
        Object request, 
        Map<String, Object> response, 
        String endpoint, 
        String soapAction, 
        String requestName, 
        String responseNamespace, 
        String responseName, 
        String responseType
    ){
        // Crear una respuesta simulada
        BillingServiceProxy.billProjectResponse_element mockResponse = new BillingServiceProxy.billProjectResponse_element();
        mockResponse.status = 'ok';  // Puedes cambiar el estado para simular distintos escenarios
        
        // Colocar la respuesta simulada en el mapa de respuesta
        response.put('response_x', mockResponse);
    }
}