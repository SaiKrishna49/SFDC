import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.gatAccounts';

export default class AccountRecordsList extends LightningElement {
    @wire(getAccounts) accounts;
    accountIdfrmparent;
    handleClick(event){
        event.preventDefault();
        this.accountIdfrmparent = event.target.dataset.accountId;
    }
}