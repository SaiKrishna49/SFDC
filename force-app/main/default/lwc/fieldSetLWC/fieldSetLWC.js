import { LightningElement,wire } from 'lwc';
import method from'@salesforce/apex/ObjectRecordsClass.getsObjects';
import method1 from'@salesforce/apex/ObjectRecordsClass.getFieldSets';
import getRecords from'@salesforce/apex/ObjectRecordsClass.getFieldSetFields';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class FieldSetTask extends LightningElement {
options;
options1;
selectedObject;
fieldSet;
columns;
data;
draftValues = [];
@wire(method)
retrieveObjects({data,error}){
let arrays=[];
arrays.push({label:'None',value:'None'});
//alert('before');
if(data){
//alert(JSON.stringify(data));
for(let key in data){
arrays.push({label:data[key],value:data[key]});
}
this.options=arrays;
//this.options = JSON.parse(JSON.stringify(this.options));
}
}
handleChange(event){
this.selectedObject=event.detail.value;
let arr=[];
method1({selectedObject:this.selectedObject})
.then((result)=>{
arr.push({label:'None',value:'None'});

for(let key in result){
    //alert(key);
arr.push({label:result[key],value:result[key]});
}


this.options1=arr;
})
}
handleChange1(event){
    var total=[];
var arrayl=[];
var columns1=[];
    alert(event.detail.value);
this.fieldSet=event.detail.value;
getRecords({objects:this.selectedObject,fieldsets:this.fieldSet})
.then((result)=>{
    for (var i = 0; i <result.labels.length ; i++) {
        columns1.push({ label:result.labels[i], fieldName:result.Names[i], type:result.Types[i], editable: true});
                
    }
    this.columns=columns1;
    for(var i=0;i<result.sobjectlist.length;i++){
                arrayl.push(result.sobjectlist[i]);
    }
    this.data=arrayl;
   
})
.catch((error)=>{
    alert('error');
});
}
    handleSave(event){
       
        this.draftValues= event.detail.draftValues;
         alert('event.detail.draftValues='+ JSON.stringify(event.detail.draftValues));
       alert('this.draftValues='+ JSON.stringify(this.draftValues));
        const inputItems =this.draftValues.slice().map(draft =>{
            var fields =[];
            alert('before');
            fields.push(draft);
           // alert(Json.stringify(fields[0]));
            return { draft };
        });
        const promises = inputItems.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res =>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'success',
                    message: 'updated successfully',
                    variant : 'Success'
                })
            );
            this.draftValues =[];
            return this.refresh();
        })/*.catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'error occured',
                    variant:'Error'
                })
            );
        })*/.finally(() => {
            this.draftValues = [];

        });
    }
    async refresh(){
        console.log('this.selectedObject='+this.selectedObject);
        alert(this.selectedObject);
        await refreshApex(this.selectedObject);
    }
}