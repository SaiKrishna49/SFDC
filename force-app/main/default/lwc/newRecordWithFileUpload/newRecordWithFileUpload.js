import { LightningElement, track } from 'lwc';  
 import saveRecord from '@salesforce/apex/ContactController1.saveContact';  
 import { NavigationMixin } from 'lightning/navigation';  
 import { ShowToastEvent } from 'lightning/platformShowToastEvent';  
 const MAX_FILE_SIZE = 100000000; //10mb  
 export default class NewRecordWithFileUpload extends NavigationMixin(LightningElement) {  
   @track name;  
   @track phone;  
   @track email;  
   @track description;  
   uploadedFiles = []; file; fileContents; fileReader; content; fileName  
   onNameChange(event) {  
     this.name = event.detail.value;  
   }  
   onPhoneChange(event) {  
     this.phone = event.detail.value;  
   }  
   onEmailChange(event) {  
     this.email = event.detail.value;  
   }  
   onDescriptionChange(event) {  
     this.description = event.detail.value;  
   }  
   onFileUpload(event) {  
     if (event.target.files.length > 0) {  
       this.uploadedFiles = event.target.files;  
       this.fileName = event.target.files[0].name;  
       this.file = this.uploadedFiles[0];  
       if (this.file.size > this.MAX_FILE_SIZE) {  
         alert("File Size Can not exceed" + MAX_FILE_SIZE);  
       }  
     }  
   }  
   saveContact() {  
     this.fileReader = new FileReader();  
     this.fileReader.onloadend = (() => {  
       this.fileContents = this.fileReader.result;  
       let base64 = 'base64,';  
       this.content = this.fileContents.indexOf(base64) + base64.length;  
       this.fileContents = this.fileContents.substring(this.content);  
       this.saveRecord();  
     });  
     this.fileReader.readAsDataURL(this.file);  
   }  
   saveRecord() {  
     var con = {  
       'sobjectType': 'Contact',  
       'LastName': this.name,  
       'Email': this.email,  
       'Phone': this.phone,  
       'Description': this.description  
     }  
     saveRecord({  
       contactRec: con,  
       file: encodeURIComponent(this.fileContents),  
       fileName: this.fileName  
     })  
       .then(conId => {  
         if (conId) {  
           this.dispatchEvent(  
             new ShowToastEvent({  
               title: 'Success',  
               variant: 'success',  
               message: 'Contact Successfully created',  
             }),  
           );  
           this[NavigationMixin.Navigate]({  
             type: 'standard__recordPage',  
             attributes: {  
               recordId: conId,  
               objectApiName: 'Contact',  
               actionName: 'view'  
             },  
           });  
         }  
       }).catch(error => {  
         console.log('error ', error);  
       });  
   }  
 }