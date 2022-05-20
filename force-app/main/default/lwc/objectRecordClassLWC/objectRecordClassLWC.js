import { LightningElement,track,wire } from 'lwc';
import method from'@salesforce/apex/ObjectRecordsClass.getObjectNames';
import method1 from'@salesforce/apex/ObjectRecordsClass.getFields';
import getRecords from'@salesforce/apex/ObjectRecordsClass.getQuerryAPI';
export default class Object_Records1 extends LightningElement {
selectedObject;
options;
options1;
selectedField=[];
data;
columns;
obectIsSelected;
totalRecords;
maxPages=0;
lastPage;
firstPage;
map;
@track pageNumber=1;
@track visibleRecords=20;
@track selectedRecords=[];
@wire(method)
retrieveObjects ({data,error}){
let arrays=[];
arrays.push({label:'None',value:'None'});
if(data){
for(let key in data){
arrays.push({label:data[key],value:data[key]});
}
this.options=arrays;
this.options = JSON.parse(JSON.stringify(this.options));
}
}
@wire(method1,{selectedObject:'$selectedObject'})
getfieldss ({data,error}){
let array1=[];
if(data){
for(let key in data){
array1.push({label:data[key],value:data[key]});
}
this.options1=array1;

}
}
handleChange1(event){
this.selectedField=event.detail.value;
alert(this.selectedField);
}
handleChange(event) {
this.selectedObject = event.detail.value;
if(this.selectedObject=='None'){
    this.selectedObject=null;
}
this.data=null;
this.selectedField=null;

}
handleClick3(){
var total=[];
var arrayl=[];
var columns1=[];
getRecords({selectfield:this.selectedField,userObj:this.selectedObject})
.then((result)=>{
    alert(result.sobjectlist.length);
    for (var i = 0; i <result.labels.length ; i++) {
        columns1.push({ label:result.labels[i], fieldName:result.Names[i], type:result.Types[i]});
                
    }
    for(var i=0;i<result.sobjectlist.length;i++){
            total.push(result.sobjectlist[i]); 
            //alert(result.sobjectlist[i].Name);
            if(i<this.visibleRecords){
                arrayl.push(result.sobjectlist[i]);
                for(var j=0;j<columns1.length;j++){
                   // alert(columns1.length);
                   // alert(result.sobjectlist[i]['Name']);
                    //alert(result.sobjectlist[i][columns1[j].fieldName]);
                    //alert(result.sobjectlist[i].key);
                }
               
            }
    }
    this.maxPages=Math.ceil(total.length/this.visibleRecords);
    this.firstPage='true';
    this.totalRecords=total;
    this.columns=columns1;
    alert(JSON.stringify(this.columns));
    this.data=arrayl;
    alert(this.data.length);
    alert(this.totalRecords.length);
})
.catch((error)=>{
    alert('error');
});


}
nextHandler(){
    if(this.pageNumber+1==this.maxPages){
this.lastPage='true';
}

this.pageNumber=this.pageNumber+1;
if(this.pageNumber>1){
    this.firstPage=null;
}
this.afterPageChange();

}
previouseHandler(){
    if(this.pageNumber-1==1){
        this.firstPage='true';
    }
this.pageNumber=this.pageNumber-1;
if(this.pageNumber<this.maxPages){
    this.lastPage=null;
}
    
this.afterPageChange();


}
afterPageChange(){
this.data=this.totalRecords.slice(((this.pageNumber-1)*this.visibleRecords),((this.pageNumber-1)*this.visibleRecords)+this.visibleRecords);
}
handleRowAction(event){
this.selectedRecords=event.detail.row;
alert(this.selectedRecords);
}
}