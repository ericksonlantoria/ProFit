public class UpdateDeleteBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        //All query that are not completed, will be deleted
        //query = SELECT ALL Event that is not equal to "Complete" for the last 4 Months
        String query = 'SELECT Id, Name FROM Event_Profit__c WHERE Status__c != \'Complete\' AND End_Date_Time__c < LAST_N_MONTHS:4';
        return Database.getQueryLocator(query);
    }
    
    
    public void execute(Database.BatchableContext batchContext, List<Event_Profit__c> eventList ){

        //Process of updating status into deleted
        List<Event_Profit__c> willDelEvtList = new List<Event_Profit__c>();
        for(Event_Profit__c evt: eventList){
            evt.Status__c = 'Deleted';
            willDelEvtList.add(evt);
        }
        update willDelEvtList;
    }
    
    public void finish(Database.BatchableContext batchContext){

        String userName = UserInfo.getUserName();
        User activeUser = [Select Name,Email From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        String actUserName = activeUser.Name;

        //Sending Email Processes
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        mail.setSubject('Batch Processing Completed');
        List<String> toAddress = new List<String>();
        toAddress.add(userEmail);
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName(actUserName);
        
        mail.setHtmlBody('Execution of the batch has been processed');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
    }
}