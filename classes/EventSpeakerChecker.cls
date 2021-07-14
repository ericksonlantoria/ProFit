public with sharing class EventSpeakerChecker {
    public static void DuplicateEventSpeaker(List<Event_Speaker__c> newEvntSpeaker){
        try {

            Set<Id> eventID = new Set<Id>();
            Set<Id> eventSpeakerID = new Set<Id>();

            //putting the event ID and speaker ID in Sets
            for(Event_Speaker__c spk : newEvntSpeaker){
                eventID.add(spk.Event__c); 
                eventSpeakerID.add(spk.Speaker__c);
            }

            //Getting Event StartDate and EndDate of the new Event
            Event_Profit__c evtDate = [SELECT Start_Date_Time__c,End_Date_Time__c FROM Event_Profit__c WHERE Id IN: eventID];
                
            //Checking all the current events of the speakers and if the new event will have conflict within it.
            List<Event_Speaker__c> spkCount = [
            SELECT Id,Event__c,Speaker__c FROM Event_Speaker__c WHERE Speaker__c IN:eventSpeakerID
            AND((Event__r.Start_Date_Time__c < :evtDate.End_Date_Time__c AND Event__r.End_Date_Time__c > :evtDate.End_Date_Time__c) 
            OR(Event__r.Start_Date_Time__c < :evtDate.Start_Date_Time__c AND Event__r.End_Date_Time__c > :evtDate.Start_Date_Time__c)
            OR(Event__r.Start_Date_Time__c >= :evtDate.Start_Date_Time__c AND Event__r.End_Date_Time__c <= :evtDate.End_Date_Time__c))];                                                       

            //Record Start_Date_Time__c < Input End_Date_Time__c and Record End_Date_Time__c > Input End_Date_Time__c
            //OR Record Start_Date_Time__c < Input End_Date_Time__c and Record End_Date_Time__c > Input Start_Date_Time__c
            //OR Record Start_Date_Time__c < Input Start_Date_Time__c and Record End_Date_Time__c > Input End_Date_Time__c

            System.debug('spkCount.size() == ' + spkCount.size());
            
            //if theres a value in spkCount, it means that there's conflict with schedule
            for(Event_Speaker__c spk : newEvntSpeaker){
                if(spkCount.size()>0){
                    System.debug('The Speaker has already an event for this day.');
                    spk.Speaker__c.addError('The Speaker has already an event for this day.');
                }
            }
        }catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }
}