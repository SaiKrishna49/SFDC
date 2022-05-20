import { LightningElement,api,wire,track} from 'lwc';
import checkinContact from '@salesforce/apex/contactclass.checkinContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Fecthemail extends LightningElement {
    @api enteredEmail;
    handleemailvalue(event) {
        this.enteredEmail = event.detail.value;
        
    }
    handleCheck(){
        checkinContact({conEmail : this.enteredEmail})
        .then(result => {
            if(result === true){
                const event = new ShowToastEvent({
                    title: 'Contact Found',
                    message: 'Found contact with same Email',
                    variant: 'success'
                });
                this.dispatchEvent(event);
            }
            else{
                const event = new ShowToastEvent({
                title : 'Contact Not Found',
                message : 'Did not found contact with the email you have entered',
                variant : 'error'
            });
            this.dispatchEvent(event);
            }
            
        })   

    }   
}