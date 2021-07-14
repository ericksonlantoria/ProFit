@isTest
public with sharing class EventDetailsController_Test {
    
    static Id createTestEvent(){
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
    static Id createTestSpeaker(){
        Speaker__c spk = new Speaker__c();
        spk.Name = 'Test spk';
        spk.Email__c = 'test@gmail.com.ph';
        spk.Phone__c = '09672688177';
        spk.Company_Name__c = 'Test Company';
        insert spk;
        // System.debug('spk.Id == ' + spk.Id );
        return spk.Id;
    }
    static Id createTestAttendee(){
        Attendee__c attn = new Attendee__c();
        attn.Name = 'Test Attendee';
        insert attn;
        return attn.Id;
    }

    @IsTest
    static void testESpeaker(){
        
        Test.startTest();
        String recId;
        Event_Speaker__c eS = new Event_Speaker__c();
        eS.Event__c = createTestEvent();
        eS.Speaker__c = createTestSpeaker();
        
        insert eS;
        
        List<Event_Speaker__c> retrievedSpeaker = EventDetailsController.getSpeakers(eS.Event__c);
        Event_Speaker__c event = retrievedSpeaker.get(0);
        
        Test.stopTest();
        System.assertEquals(eS.Event__c,event.Event__c);
    }
    @IsTest
    static void testLocation(){
        Test.startTest();
        String recId = createTestEvent();
        List<Event_Profit__c> evts = EventDetailsController.getLocationDetails(recId);
        Event_Profit__c event = evts.get(0);
        Test.stopTest();
        System.assertEquals(recId,event.Id);
    }

    @isTest
    static void testAttendee(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Attendee__c = createTestAttendee();
        eA.Event_ProFit__c = createTestEvent();
        insert eA;
        
        List<Event_Attendee__c> retrievedAttendee = EventDetailsController.getAttendees(eA.Event_ProFit__c);
        
        Event_Attendee__c eatt = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals(eA.Event_ProFit__c, eatt.Event_ProFit__c);
    }
}