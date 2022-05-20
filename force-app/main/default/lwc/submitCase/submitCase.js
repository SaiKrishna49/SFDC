import { LightningElement, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CASE_OBJECT from '@salesforce/schema/Case';
import SUBJECT_FIELD from '@salesforce/schema/Case.Subject';
import DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';
import CONTACTEMAIL_FIELD from '@salesforce/schema/Case.ContactEmail';  
export default class CreateAccountRecord extends LightningElement {
    objectApiName=CASE_OBJECT;
    fields = [SUBJECT_FIELD,DESCRIPTION_FIELD,CONTACTEMAIL_FIELD];
    @api recordId;
    get acceptedFormats() {
        return ['.pdf', '.png','.jpg','.jpeg'];
    }
    handleUploadFinished(event) {
        console.log('entdetailfiles='+ event.detail.files);
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        let uploadedFileNames = '';
        for(let i = 0; i < uploadedFiles.length; i++) {
            uploadedFileNames += uploadedFiles[i].name + ', ';
            console.log('upload files='+uploadedFiles);
        }
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: uploadedFiles.length + ' Files uploaded Successfully: ' + uploadedFileNames,
                variant: 'success',
            }),
        );
    }
}