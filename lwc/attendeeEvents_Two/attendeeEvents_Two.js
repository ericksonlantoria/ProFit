import { LightningElement, wire, api } from 'lwc';
import getUpcomingEvents from '@salesforce/apex/AttendeeEventService_Two.getUpcomingEvents'
import getPastEvents from '@salesforce/apex/AttendeeEventService_Two.getPastEvents'

const COLUMNS = [
    {label:'Event Name', fieldName: 'EventName', type:'text' },
    {label:'Event Location', fieldName: 'EventLocation', type:'text' },
    {
        label: 'Start Date and Time',
        fieldName: 'EventStartDate',
        type: 'date',
        typeAttributes: {
            weekday: 'long',
            day: 'numeric',
            month: 'short',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            hour12: true
        }
    },
    {
        label: 'End Date and Time',
        fieldName: 'EventEndDate',
        type: 'date',
        typeAttributes: {
            weekday: 'long',
            day: 'numeric',
            month: 'short',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            hour12: true
        }
    }
]

export default class AttendeeEvents_Two extends LightningElement {
    @api recordId;
    upcomingEventsTableData
    pastEventsTableData
    columns = COLUMNS

    //populating upcomingEventsTableData
    @wire (getUpcomingEvents, {attendeeId : '$recordId'}) 
    upcomingEventsRecord({error, data}){
        if(data){
           console.log(data);
           this.upcomingEventsTableData = data;
           let preparedDatas = [];
           this.upcomingEventsTableData.forEach(dat =>{
               let preparedData = {};
               let loc;
               if(dat.Event_ProFit__r.Location__c){
                   loc = dat.Event_ProFit__r.Location__r.Name;
               }
               else{
                   loc = "Doesn't have location";
               }
               preparedData.EventName = dat.Event_ProFit__r.Name;
               preparedData.EventStartDate = dat.Event_ProFit__r.Start_Date_Time__c;
               preparedData.EventEndDate = dat.Event_ProFit__r.End_Date_Time__c;
               preparedData.EventLocation = loc;

               preparedDatas.push(preparedData);
               console.log(preparedDatas);
           });
           this.upcomingEventsTableData = preparedDatas;
        }else if(error){
            console.error(error);
        }
    }

    //populating pastEventsTableData
    @wire (getPastEvents, {attendeeId : '$recordId'}) 
    pastEventsRecord({error, data}){
        if(data){
           console.log(data);
           this.pastEventsTableData = data;
           let preparedDatas = [];
           this.pastEventsTableData.forEach(dat =>{
               let preparedData = {};
               let loc;
               if(dat.Event_ProFit__r.Location__c){
                   loc = dat.Event_ProFit__r.Location__r.Name;
               }
               else{
                   loc = "Doesn't have location";
               }
               preparedData.EventName = dat.Event_ProFit__r.Name;
               preparedData.EventStartDate = dat.Event_ProFit__r.Start_Date_Time__c;
               preparedData.EventEndDate = dat.Event_ProFit__r.End_Date_Time__c;
               preparedData.EventLocation = loc;

               preparedDatas.push(preparedData);
               console.log(preparedDatas);
           });
           this.pastEventsTableData = preparedDatas;
        }
        else if(error){
            console.error(error);
        }
    }

}