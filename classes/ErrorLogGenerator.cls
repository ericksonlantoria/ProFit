public with sharing class ErrorLogGenerator {
    public static void createErrorLog(String processName, String details, Datetime logDate){
    
   Error_Log__c err = new Error_Log__c();
   err.Process_Name__c = processName;
   err.Log_Details__c = details;
   err.Log_Date_Time__c = logDate;
   insert err;
    }
}