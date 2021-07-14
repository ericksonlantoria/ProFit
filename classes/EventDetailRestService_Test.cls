@istest
public with sharing class EventDetailRestService_Test {
    
    //Creating new Event
    static Id createEventTestRecord(){
        Event_ProFit__c evt = new Event_ProFit__c();
        evt.Name = 'Test Record REST Service';
        evt.Start_Date_Time__c = datetime.newInstance(2021, 6, 26, 11, 00, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 6, 27, 12, 00, 0);
        evt.Event__c ='Virtual';
        evt.Live__c = true;
        evt.Status__c = 'Created';
        insert evt;
        return evt.Id;
    }

    //Testing the doGetEvt() by calling the event
    @IsTest
    static void doGetTest(){
        Test.startTest();
            Id eventId =  createEventTestRecord();
            RestRequest req = new RestRequest();
            req.requestURI = 'e-cmixrecords--sandboxpro.my.salesforce.com/services/apexrest/api/Event__c/'+EventId;
            req.httpMethod = 'GET';
            RestContext.request = req;
            Event_ProFit__c evt = EventDetailRestService.doGetEvt();
            System.assertEquals(eventId, evt.Id);
        Test.stopTest();
    }
}