@isTest
private class EventSpeakerChecker_Test{
  Static Id createTestEventId(){
    
    //Mock Creation: New Event Record
    //and Fill-out all the required field
    Event_Profit__c evt = new Event_Profit__c();
    evt.Name = 'Test Event';
    evt.Live__c = true;
    evt.Max_Seats__c	= 50;
    evt.Start_Date_Time__c = datetime.newInstance(2021, 7, 21, 19, 30, 0);
    evt.End_Date_Time__c = datetime.newInstance(2021, 7, 22, 19, 30, 0);
    
    insert evt;
    System.debug('evt.Id == ' + evt.Id );
    return evt.Id;
  }
  
  Static Id createTestSpeakerId(){
  
    //Mock Creation: New Speaker Record
    Speaker__c spk = new Speaker__c();
    spk.Name = 'Test spk';
    spk.Email__c = 'test@gmail.com.ph';
    spk.Phone__c = '09672688177';
    spk.Company_Name__c = 'Test Company';
    insert spk;
    System.debug('spk.Id == ' + spk.Id );
    return spk.Id;
  }
  
  @IsTest 
  Static void checkEventSpeaker(){
    Test.startTest();
    
    //Creating a new Event-Speaker Record
    Event_Speaker__c eSpeak = new Event_Speaker__c();
    eSpeak.Event__c	= createTestEventId();
    eSpeak.Speaker__c = createTestSpeakerId();
    
    insert eSpeak;

    //Checking if the Test is successful by identifying if the inserted Id of the event
    //is equal to the output in retrievedESpeak.Event__c
    Event_Speaker__c retrievedESpeak = [SELECT Event__c FROM Event_Speaker__c WHERE Event__c =: eSpeak.Event__c];
    Test.stopTest();
  
    System.assertEquals(eSpeak.Event__c,retrievedESpeak.Event__c);
  }
}