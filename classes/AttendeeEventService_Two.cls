public with sharing class AttendeeEventService_Two {
    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> getUpcomingEvents(String attendeeId){
        List<Event_Attendee__c> query = [Select Id, Name, Event_ProFit__c, Event_ProFit__r.Start_Date_Time__c, Event_ProFit__r.End_Date_Time__c, Event_ProFit__r.Name, Event_ProFit__r.Location__r.Name from Event_Attendee__c where Attendee__c =: attendeeId and Event_ProFit__r.Start_Date_Time__c >= today];
        System.debug(query);
        return query;
    }

    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> getPastEvents(String attendeeId){
        List<Event_Attendee__c> query = [Select Id, Name, Event_ProFit__c, Event_ProFit__r.Start_Date_Time__c, Event_ProFit__r.End_Date_Time__c, Event_ProFit__r.Name, Event_ProFit__r.Location__r.Name from Event_Attendee__c where Attendee__c =: attendeeId and Event_ProFit__r.Start_Date_Time__c < today];
        System.debug(query);
        return query;
    }
}
