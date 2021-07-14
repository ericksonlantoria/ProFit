@IsTest
public with sharing class AttendeeEventService_Test {

    //Creating New Event
    static Id createTestNewEvent(){
        Event_Profit__c evt = new Event_Profit__c();
        evt.Name = 'Test Event';
        evt.Live__c = true;
        evt.Start_Date_Time__c = datetime.newInstance(2021, 7, 25, 19, 30, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 7, 26, 19, 30, 0);
        evt.Max_Seats__c = 50;

        insert evt;
        // System.debug('evt.Id == ' + evt.Id );
        return evt.Id;
    }
    //Creating Old Event
    static Id createTestOldEvent(){
        Event_Profit__c evt = new Event_Profit__c();
        evt.Name = 'Test Old Event';
        evt.Live__c = true;
        evt.Start_Date_Time__c = datetime.newInstance(2020, 12, 25, 19, 30, 0);
        evt.End_Date_Time__c = datetime.newInstance(2020, 12, 26, 19, 30, 0);
        evt.Max_Seats__c = 50;

        insert evt;
        // System.debug('evt.Id == ' + evt.Id );
        return evt.Id;
    }
    //Creating Test Attendee
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        insert att;
        return att.Id;
    }

    //Testing upcoming events
    @IsTest
    static void testUpcomingEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event_Profit__c = createTestNewEvent();
        eA.Attendee__c = createTestAttendee();
        insert eA;

        Map<Id,Event_Attendee__c> retrievedEventAttn = new Map<Id,Event_Attendee__c>(AttendeeEventService_Two.getUpcomingEvents(eA.Attendee__c));
        // System.debug(retrievedEventAttn.containskey(eA.Id));
        Test.stopTest();

        System.assertEquals(True, retrievedEventAttn.containskey(eA.Id));
    }

    //Testing old events
    @IsTest
    static void testPastEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event_Profit__c = createTestOldEvent();
        eA.Attendee__c = createTestAttendee();
        insert eA;

        Map<Id,Event_Attendee__c> retrievedEventAttn = new Map<Id,Event_Attendee__c>(AttendeeEventService_Two.getPastEvents(eA.Attendee__c));
        // System.debug(retrievedEventAttn.containskey(eA.Id));
        Test.stopTest();

        System.assertEquals(True, retrievedEventAttn.containskey(eA.Id));
    }
}
