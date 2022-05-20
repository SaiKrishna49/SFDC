import { LightningElement,api,wire,track } from 'lwc';
import checkinContact from '@salesforce/apex/contactclass.checkinContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class FileUploadOnRecordInsert extends LightningElement {
  @track recId;
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

handleUpload(event){
    this.showButtons = true;
    this.recId = event.detail.id;
    this.showToast('Information','info','You can upload multiple files now!!!');
    }
showToast(title,variant,message){
    const event = new ShowToastEvent({
    title: title,
    message: message,
    variant: variant
    });
    this.dispatchEvent(event);
    }
get acceptedFormats() {
    return ['.pdf', '.png','.jpg','.jpeg','.txt','.docx','.attachment','.js','.cls','.apxt','.html','.zip'];
}
handleUploadFinished(event) {
    let strFileNames = '';
    const uploadedFiles = event.detail.files;
    for(let i = 0; i < uploadedFiles.length; i++) {
    strFileNames += uploadedFiles[i].name + ', ';
    }
this.showToast('Success!!','success',strFileNames + ' Files uploaded Successfully!!!');
    }
handleFinish(event){
    this.handleReset();
    this.recId = undefined;
    this.showButtons = false;
    this.showToast('Success','success','Case created Successfully!! ');
   
    }
handleReset() {
    const inputFields = this.template.querySelectorAll('lightning-input-field');
    if (inputFields) {
    inputFields.forEach(field => {
    field.reset();
    })
    if(Input){
      Input.forEach(field => {
      field.reset();
      });
    }
}
}
}
























/*import { LightningElement, track } from 'lwc';  
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
 }  */