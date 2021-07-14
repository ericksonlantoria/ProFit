public with sharing class EventDetailsController {
    @AuraEnabled(cacheable = true)
    public static List<Event_Speaker__c> getSpeakers(String eventId) {
      List<Event_Speaker__c> speakerList = [
        SELECT
          Id,
          Name,
          Speaker__c,
          Speaker__r.Name,
          Speaker__r.Phone__c,
          Speaker__r.Email__c,
          Speaker__r.Company_Name__c,
          Event__c
        FROM Event_Speaker__c
        WHERE Event__c = :eventId
      ];
      return speakerList;
    }
  
    @AuraEnabled(cacheable = true)
    public static List<Event_Profit__c> getLocationDetails(String eventId) {
      List<Event_Profit__c> location = [
        SELECT
          Id,
          Name,
          Location__c,
          Location__r.Name,
          Location__r.City__c,
          Location__r.Country__c,
          Location__r.Landmark__c,
          Location__r.Postal_Code__c,
          Location__r.State__c,
          Location__r.Street__c
        FROM Event_Profit__c
        WHERE Id = :eventId
      ];
      return location;
    }
  
    @AuraEnabled(cacheable = true)
    public static List<Event_Attendee__c> getAttendees(String eventId) {
      List<Event_Attendee__c> eventAttendeeList = [
        SELECT
          Id,
          Name,
          Attendee__c,
          Attendee__r.Name,
          Attendee__r.Email__c,
          Attendee__r.Company_Name__c,
          Attendee__r.Location__c,
          Attendee__r.Location__r.Name,
          Event_ProFit__c
        FROM Event_Attendee__c
        WHERE Event_Profit__c = :eventId
      ];
      return eventAttendeeList;
    }
  }