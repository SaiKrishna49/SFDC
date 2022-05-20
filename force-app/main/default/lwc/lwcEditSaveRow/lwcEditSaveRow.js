import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/lwcEditSaveRowCtrl.getAccounts';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const columns = [
    {
        label: 'ID',
        fieldName: 'ID',
        type: 'text',
    },
    {
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
    }, {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
        editable: true,
    }, {
        label: 'Industry',
        fieldName: 'Industry',
        type: 'text',
        editable: true,
    }, {
        label: 'Type',
        fieldName: 'Type',
        type: 'text',
        editable: true
    }, {
        label: 'Description',
        fieldName: 'Type',
        type: 'text',
        editable: true
    }
    
];
export default class LwcEditSaveRow extends LightningElement {
    columns = columns;
    @track accObj;
    fldsItemValues = [];

    @wire(getAccounts)
    cons(result) {
        this.accObj = result;
        if (result.error) {
            this.accObj = undefined;
        }
    };

    saveHandleAction(event) {
        this.fldsItemValues = event.detail.draftValues;
        const inputsItems = this.fldsItemValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

       
        const promises = inputsItems.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            this.fldsItemValues = [];
            return this.refresh();
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.fldsItemValues = [];
        });
    }

   
    async refresh() {
        await refreshApex(this.accObj);
    }
}