import { LightningElement,api,wire } from 'lwc';
import {getRecord,getFieldValue} from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';

const fields = [NAME_FIELD];
export default class Ownerlwc extends LightningElement {
    lookupId;

    @wire(getRecord, {
        recordId: '$lookupId',
        fields
    })
    account;
    get accountName() {
        return getFieldValue(this.account.data, NAME_FIELD);
    }
    handleLookupFieldChange(event) {
        this.lookupId = event.target.value;
        alert(event.target.value); // "001***************"
        alert(event.detail.value[0]); // "001***************"
    }
}