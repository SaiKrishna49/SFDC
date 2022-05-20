import {LightningElement} from 'lwc';

export default class LookupExample extends LightningElement {

    selectedAccount;

    handleAccountSelection(event){
        this.selectedAccount = event.target.value;
        alert("The selected Accout id is"+this.selectedAccount);
    }
}