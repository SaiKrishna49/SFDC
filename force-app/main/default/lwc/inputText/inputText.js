import { LightningElement, track } from 'lwc';

export default class InputText extends LightningElement {
    @track message;


    handleChange(event){
        this.message = event.target.value;
    }
}