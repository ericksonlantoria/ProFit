public with sharing class SendEmailToAEventAttendee {
    public static void sendConfirmationEmail(List<Event_Attendee__c> newRecordList ) {
        
        //Getting the AttendeeId and EventId for accessing the objects later
        Set<Id> attendeesIdsSet = new Set<Id>();
        Set<Id> eventIdsSet = new Set<Id>();
        
        for(Event_Attendee__c eAttn : newRecordList){
            attendeesIdsSet.add(eAttn.Attendee__c);
            eventIdsSet.add(eAttn.Event_Profit__c);
        }
        
        //getting all the needed information of the Attendee which is name and email
        Map<Id,Attendee__c> attendeeMap = new Map<Id,Attendee__c>( 
            [Select Id, Name, Email__c From Attendee__c WHERE  Id IN : attendeesIdsSet]
        );
        
        //getting all the information of the Event that are needed for the creation of email
        Map<Id, Event_Profit__c > eventMap = new Map<Id, Event_Profit__c > ( [Select Id, Name, Start_Date_Time__c, End_Date_Time__c, Organizer__c , Organizer__r.Name,Location__c , Location__r.Name, Location__r.City__c,Location__r.State__c, Location__r.Country__c,Location__r.Postal_Code__c, Location__r.Street__c FROM Event_Profit__c  WHERE ID IN: eventIdsSet]);
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        // Map<Id, Event_Attendee__c> evtmap = Map<Id, Event_Attendee__c>();

        for(Event_Attendee__c eAttn : newRecordList){
            
            Attendee__c attn = attendeeMap.get(eAttn.Attendee__c);
            Event_Profit__c evt = eventMap.get(eAttn.Event_Profit__c);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setSubject('Pass for the '+evt.Name);
            List<String> toEmailAddress = new List<String>();
            toEmailAddress.add(attn.Email__c);
            mail.setToAddresses( toEmailAddress );
            mail.setSenderDisplayName(evt.Organizer__r.Name);
            
            String loc = 'https://www.google.com/maps/place/'+evt.Location__r.Street__c+' '+evt.Location__r.City__c+' '
                +evt.Location__r.State__c+' '+
                evt.Location__r.Country__c+' '+evt.Location__r.Postal_Code__c;
            String hrefForLocation = '<a href="'+loc+'"'+'target="_blank">Here</a>';
            String eBody = 'Dear '+ attn.Name + ',<br/><br/>'+
                'Thank you for your registering for '+ evt.Name + ' which will be Organized on '+ evt.Start_Date_Time__c+' To '+evt.End_Date_Time__c+' & will be held in '+ evt.Location__r.Name+'. We are excited to have you, see you in the event.<br/><br/> Find the Google Map Location for the Event '+ hrefForLocation + '.<br/><br/><br/>'+
                'Thank you so much,<br/>'+evt.Organizer__r.Name;
            
            mail.setHtmlBody(eBody);
            emailList.add(mail); 
        }
        
        try{
            List<Messaging.SendEmailResult> results =  Messaging.sendEmail(emailList, false); 
            for(Messaging.SendEmailResult email : results){
                if(!email.isSuccess()){
                    List<Messaging.SendEmailError> errors = email.getErrors();
                }else{
                    System.debug('Email Succesfully Sent');
                }
            }  
        }catch(System.Exception ex){
            System.debug('Error Message: ' + ex);
        }
    }
}