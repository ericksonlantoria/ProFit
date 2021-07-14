@isTest
private class SendEmailToAEventAttendee_Test{

    //Mock Creation: new Event Record
    Static Id createTestEventId(){
    
        Event_Profit__c evt = new Event_Profit__c();
        evt.Name = 'Test Event';
        evt.Live__c = true;
        evt.Start_Date_Time__c = datetime.newInstance(2021, 7, 21, 19, 30, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 7, 22, 19, 30, 0);
        evt.Max_Seats__c = 10;
        
        insert evt;
        System.debug('evt.Id == ' + evt.Id );
        return evt.Id;
    }

    //Create new Attendee Record
    Static Id createTestAttendeeId(){
        Attendee__c attn = new Attendee__c();
        attn.Name = 'Test Attendee';
        attn.Company_Name__c = 'Test Company';
        attn.Email__c = 'testemail@gmail.com';
        attn.Phone__c = '09672688177';

        insert attn;
        System.debug('attn.Id == '+ attn.Id);
        return attn.Id;
    }


    @isTest
    Static void checkEventAttendee(){
        Test.startTest();

        Event_Attendee__c eAttendee = new Event_Attendee__c();
        eAttendee.Event_ProFit__c = createTestEventId();
        eAttendee.Attendee__c = createTestAttendeeId();

        insert eAttendee;

        System.debug('eAttendee.Id == ' + eAttendee.Id);
        
        //Check if successful if the record inserted and retrieved are equal
        Event_Attendee__c retrievedEAttn = [SELECT Event_ProFit__c FROM Event_Attendee__c WHERE Event_ProFit__c =: eAttendee.Event_ProFit__c];

        Test.stopTest();
            
        System.assertEquals(eAttendee.Event_ProFit__c,retrievedEAttn.Event_ProFit__c);
    }
}