@RestResource(urlMapping = '/api/Event_Profit__c/*')
global with sharing class EventDetailRestService {
    @HTTPGet
    global static Event_Profit__c doGetEvt(){
        RestRequest req = RestContext.request;
        
        //Getting the evt Id after '/' *see at POSTMAN
        String evtId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Event_Profit__c result = [Select Id, Name, Location__r.Name, Organizer__r.Name, Live__c, Start_Date_Time__c, End_Date_Time__c from Event_Profit__c where Id =: evtId];
        return result;
    }
}