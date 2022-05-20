import { LightningElement, api, track } from 'lwc';
import getFieldsAndRecords from '@salesforce/apex/FieldSetHelper.getFieldsAndRecords';

export default class LwcFieldSetComponent extends LightningElement {
    
    @api recordId;  // record id from record detail page e.g. ''0012v00002WCUdxAAH'
    @api SFDCobjectApiName; //kind of related list object API Name e.g. 'Case'
    @api fieldSetName; // FieldSet which is defined on that above object e.g. 'CaseRelatedListFS'
    @api criteriaFieldAPIName; // This field will be used in WHERE condition e.g.'AccountId'
    @api firstColumnAsRecordHyperLink; //if the first column can be displayed as hyperlink

    @track columns;   //columns for List of fields datatable
    @track tableData;   //data for list of fields datatable
    
    recordCount; //this displays record count inside the ()
    lblobjectName; //this displays the Object Name whose records are getting displayed

    connectedCallback(){
        let firstTimeEntry = false;
        let firstFieldAPI;

        //make an implicit call to fetch records from database
        getFieldsAndRecords({ strObjectApiName: this.SFDCobjectApiName,
                                strfieldSetName: this.fieldSetName,
                                criteriaField: this.criteriaFieldAPIName,
                                criteriaFieldValue: this.recordId})
        .then(data=>{        
            //get the entire map
            let objStr = JSON.parse(data);   
            
            /* retrieve listOfFields from the map,
             here order is reverse of the way it has been inserted in the map */
            let listOfFields= JSON.parse(Object.values(objStr)[1]);
            
            //retrieve listOfRecords from the map
            let listOfRecords = JSON.parse(Object.values(objStr)[0]);

            let items = []; //local array to prepare columns

            /*if user wants to display first column has hyperlink and clicking on the link it will
                naviagte to record detail page. Below code prepare the first column with type = url
            */
            listOfFields.map(element=>{
                //it will enter this if-block just once
                if(this.firstColumnAsRecordHyperLink !=null && this.firstColumnAsRecordHyperLink=='Yes'
                                                        && firstTimeEntry==false){
                    firstFieldAPI  = element.fieldPath; 
                    //perpare first column as hyperlink                                     
                    items = [...items ,
                                    {
                                        label: element.label, 
                                        fieldName: 'URLField',
                                        fixedWidth: 150,
                                        type: 'url', 
                                        typeAttributes: { 
                                            label: {
                                                fieldName: element.fieldPath
                                            },
                                            target: '_blank'
                                        },
                                        sortable: true 
                                    }
                    ];
                    firstTimeEntry = true;
                } else {
                    items = [...items ,{label: element.label, 
                        fieldName: element.fieldPath}];
                }   
            });
            //finally assigns item array to columns
            this.columns = items; 
            this.tableData = listOfRecords;

            console.log('listOfRecords',listOfRecords);
            /*if user wants to display first column has hyperlink and clicking on the link it will
                naviagte to record detail page. Below code prepare the field value of first column
            */
            if(this.firstColumnAsRecordHyperLink !=null && this.firstColumnAsRecordHyperLink=='Yes'){
                let URLField;
                //retrieve Id, create URL with Id and push it into the array
                this.tableData = listOfRecords.map(item=>{
                    URLField = '/lightning/r/' + this.SFDCobjectApiName + '/' + item.Id + '/view';
                    return {...item,URLField};                     
                });
                
                //now create final array excluding firstFieldAPI
                this.tableData = this.tableData.filter(item => item.fieldPath  != firstFieldAPI);
            }

            //assign values to display Object Name and Record Count on the screen
            this.lblobjectName = this.SFDCobjectApiName;
            this.recordCount = this.tableData.length;
            this.error = undefined;   
        })
        .catch(error =>{
            this.error = error;
            console.log('error',error);
            this.tableData = undefined;
            this.lblobjectName = this.SFDCobjectApiName;
        })        
    }
}