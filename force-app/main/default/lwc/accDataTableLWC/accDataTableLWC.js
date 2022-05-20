import { LightningElement, api, wire, track} from 'lwc';
import getAccList from '@salesforce/apex/AccDataTableClass.getAccList';

export default class AccDataTableLWC extends LightningElement {
    @track columns = [{
              label : 'Account Name',
              fieldName : 'Name',
              type : 'Text',
              sortable : true
    },
    {
            label : 'Type',
            fieldName : 'Type',
            type : 'Text',
            sortable : true
    },
    {
            label : 'Annual Revenue',
            fieldName : 'Annual Revenue',
            type : 'Currency',
            sortable : true
    },
    {
            label : 'Phone',
            fieldName : 'Phone',
            type : 'Phone',
            sortable : true
    },
    {
            label : 'Website',
            fieldName : 'Website',
            type : 'url',
            sortable : true
    },
    {
            label : 'Rating',
            fieldName : 'Rating',
            type : 'Text',
            sortable : true
    }];
    @track error;
    @track AccList;
    @wire(getAccList) wiredAccounts({
        error,
        data
    }) {
            if(data) {
                this.AccList = data;
            } else if (error){
                this.error = error;
            }
    }
}