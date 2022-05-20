import { LightningElement,api,wire,track} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CustomStatus from'@salesforce/schema/Lead.CustomStatus__c'
import Record_Type from '@salesforce/schema/Lead.RecordTypeId'
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import updateLeadStatusMethod from'@salesforce/apex/progressIndicatorController.updateLeadStatus';
export default class lWCProgressIndicator extends LightningElement {
     @track recordTypeId;
     @track current;
     @api recordId;
     @track steps=[];
     @track currentConfirm;
     @track button=true;

     @wire(getRecord, { recordId: '$recordId', fields:[Record_Type,CustomStatus]})
     getrecordtypeId(result){
     
         for(let key in result.data){
             if(key==='fields'){
                 for(let k in result.data[key]){
                     console.log(k);
                     if(k==='RecordTypeId'){
                 
                this.recordTypeId=result.data[key][k].value;
                     }
                     if(k==='CustomStatus__c'){
                        this.currentConfirm=result.data[key][k].value;
                     }
                 }
            }
            
         }
         
      
     }
     @wire(getPicklistValues, { recordTypeId:'$recordTypeId', fieldApiName: CustomStatus })
     orderTypeOption(result){
    
         for(let key in result.data){
             if(key==='values'){
                 for(let k in result.data[key]){
                    this.steps.push({label:result.data[key][k].label,value:result.data[key][k].value});
                 }
             }
         
         }
         
     }
     currentHandler(event){
         
         this.current=event.target.value;
alert('alerttt');
console.log('this.current  + this.currentConfirm=='+this.current  + this.currentConfirm);
         alert(this.current  + this.currentConfirm);
         if(this.current !== this.currentConfirm){

         this.button=false;
         }
       
     }
     MarkingProgress(){
         this.button=true;
         this.currentConfirm=this.current;
         updateLeadStatusMethod({Id:this.recordId,status:this.currentConfirm})
        .then(result=>{
            this.showToast();
            eval("$A.get('e.force:refreshView').fire();");
           
         
        })
    .catch(error=>{
        alert('Error')
    });;
     }
     showToast() {
        const event = new ShowToastEvent({
            title: '',
            message: 'Status Changed Successfully',
            variant: 'success',
            mode: 'dismissable'
        });
         this.button=true;
        this.dispatchEvent(event);
    }
}