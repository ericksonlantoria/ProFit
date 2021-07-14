import { LightningElement, wire, api } from 'lwc';
import getSpeakers from "@salesforce/apex/EventDetailsController.getSpeakers";
import getLocationDetails from "@salesforce/apex/EventDetailsController.getLocationDetails";
import getAttendees from "@salesforce/apex/EventDetailsController.getAttendees";

const SPKCOLUMNS = [
    { label: 'Speaker Name', fieldName: 'SpeakerName', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email Address', fieldName: 'SpkEmailAdd', type: 'email' },
    { label: 'Company Name', fieldName: 'SpkCompanyName', type: 'text' }
]

const LOCCOLUMNS = [
    { label: 'Location Name', fieldName: 'LocName', type: 'text' },
    { label: 'Street', fieldName: 'Street', type: 'text' },
    { label: 'City', fieldName: 'City', type: 'text' },
    { label: 'Landmark', fieldName: 'Landmark', type: 'text' },
    { label: 'Postal Code', fieldName: 'PostalCode', type: 'text' },
    { label: 'State', fieldName: 'State', type: 'text' }
]

const ATTNCOLUMNS = [
    { label: 'Attendee Name', fieldName: 'AttendeeName', type: 'text' },
    { label: 'Email Address', fieldName: 'AttnEmailAdd', type: 'email' },
    { label: 'Company Name', fieldName: 'AttnCompanyName', type: 'text' }
]

export default class EventDetails_Two extends LightningElement {
    @api recordId;
    
    error1;
    error2;
    error3;
    
    spkColumns = SPKCOLUMNS
    locColumns = LOCCOLUMNS
    attnColumns = ATTNCOLUMNS

    speakerTableData
    locationTableData
    attendeeTableData
    
    @wire(getSpeakers, {eventId : '$recordId'})
    speakersRecords({error, data}){
        if(data){
            this.speakerTableData = data;
            let preparedDatas = [];
            this.speakerTableData.forEach(dat =>{
               let preparedData = {};
               if(dat.Speaker__c != null){
                preparedData.SpeakerName = dat.Speaker__r.Name;
                preparedData.Phone = dat.Speaker__r.Phone__c;
                preparedData.SpkEmailAdd = dat.Speaker__r.Email__c;
                preparedData.SpkCompanyName = dat.Speaker__r.Company_Name__c;
               }else{
                preparedData.SpeakerName = 'No Speaker';
               }
               console.log(this.speakerTableData);
               preparedDatas.push(preparedData);
           });
           this.speakerTableData = preparedDatas;
        }else if(error){
            this.error1 = error;
        }
    }

    @wire(getLocationDetails, {eventId : '$recordId'})
    locationRecords({error, data}){
        if(data){
            this.locationTableData = data;
            let preparedDatas = [];
            // console.log(this.locationTableData);
            this.locationTableData.forEach(dat =>{
            let preparedData = {};

            if(dat.Location__c != null){
               preparedData.LocName = dat.Location__r.Name;
               preparedData.Street = dat.Location__r.Street__c;
               preparedData.City = dat.Location__r.City__c;
               preparedData.Landmark = dat.Location__r.Landmark__c;
               preparedData.PostalCode = dat.Location__r.Postal_Code__c;
               preparedData.State = dat.Location__r.State__c;
            }
            else{
                preparedData.LocName = 'Does not have a location';
            }
               preparedDatas.push(preparedData);
           });
           this.locationTableData = preparedDatas;
        }else if(error){
           this.error2 = error;
        }
    }

    @wire(getAttendees, {eventId : '$recordId'})
    attendeesRecords({error, data}){
        if(data){
            this.attendeeTableData = data;
            let preparedDatas = [];
            console.log(this.attendeeTableData);
            this.attendeeTableData.forEach(dat =>{
               let preparedData = {};
               if(dat.Attendee__c != null){
                preparedData.AttendeeName = dat.Attendee__r.Name;
                preparedData.AttnEmailAdd = dat.Attendee__r.Email__c;
                preparedData.AttnCompanyName = dat.Attendee__r.Company_Name__c; 
               }
               preparedDatas.push(preparedData);
           });
           this.attendeeTableData = preparedDatas;
        }else if(error){
            this.error3 = error;
        }
    }

}