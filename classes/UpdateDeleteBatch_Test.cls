@isTest
private class UpdateDeleteBatch_Test {

    public static testMethod void testUpdateBatch(){

        List<Event_Profit__c> eventList = new List<Event_Profit__c>();
        for(Integer i=0; i<100; i++){
            Event_Profit__c event = new Event_Profit__c(
                Name = 'Test Event No.'+i+1,
                Live__c = false,
                Status__c = 'Created',
                Max_Seats__c = 20,
                Start_Date_Time__c = datetime.newInstance(2020, 12, 1, 12, 0, 0),
                End_Date_Time__c  = datetime.newInstance(2020, 12, 4, 12, 0, 0)
            );
            eventList.add(event);
        }
        insert eventList;
        try{
            Test.startTest();

            UpdateDeleteBatch updel = new UpdateDeleteBatch();
            Database.executeBatch(updel,200);
            
            Test.stopTest();
        }catch (Exception ex){
            System.debug('Error Message: ' + ex);
        }
        System.AssertEquals(database.countquery('SELECT COUNT() From Event_Profit__c Where Status__c != \'Complete\''),100);  
    }
}