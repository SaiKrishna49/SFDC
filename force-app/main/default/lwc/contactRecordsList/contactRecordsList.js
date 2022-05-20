import { LightningElement,wire,api,track } from 'lwc';
import findcontactbyAccountId from '@salesforce/apex/contactController.findcontactbyAccountId';
const columns = [
    { label : 'First name', fieldName: 'FirstName'},
    { label : 'Last name', fieldName : 'LastName'},
    { Label : 'Email', fieldName : 'email'},
];
export default class ContactRecordList extends LightningElement {
    columns = columns;
    @api accountId;
    @wire(findcontactbyAccountId,{accountId:'$accountId'}) contacts;
}