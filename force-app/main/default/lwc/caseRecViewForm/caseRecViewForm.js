import { LightningElement, api, wire, track } from 'lwc';  
import fetchCase from '@salesforce/apex/CaseEscalationController.fetchCase';  
import { ShowToastEvent } from 'lightning/platformShowToastEvent';  
  
export default class CaseEscalation extends LightningElement {  
  
    @api recId;  
    @track parentCaseId;  
    @track viewBool;  
    @track editBool;  
    @track newBool;  
  
    @wire(fetchCase, { strRecordId: '$recId' })  
    caseRecord({ error, data }) {  
  
        if ( data ) {  
  
            this.parentCaseId = data.Id;  
  
        }   
        if ( this.parentCaseId ) {  
  
            this.newBool = false;  
            this.editBool = true;  
  
        } else{  
              
            this.newBool = true;  
            this.editBool = false;  
  
        }  
        this.viewBool = false;  
          
    }  
  
    handleSuccess( event ) {  
          
        const toastEvent = new ShowToastEvent({  
            title: 'Case Updated',  
            message: 'Case Updated Successfully!!!',  
            variant: 'success'  
        });  
        this.dispatchEvent( toastEvent );  
        this.viewBool = true;  
        this.editBool = false;  
        this.newBool = false;  
  
    }  
  
    handleCreate( createEvent ) {  
          
        const toastEvent = new ShowToastEvent({  
            title: 'Case Created',  
            message: 'Case Created Successfully!!!',  
            variant: 'success'  
        });  
        this.dispatchEvent( toastEvent );  
        this.viewBool = true;  
        this.editBool = false;  
        this.newBool = false;  
        this.parentCaseId = createEvent.detail.id;  
  
    }  
  
}