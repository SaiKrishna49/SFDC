//**************************************************************************************************
//*** Js Name : ObjectRecordsController
//*** Class Description : This Js is connecting the objectRecords class and ObjectRecords Component.
//*** Author : krishna
//*** Class Created Date : 23-12-2021
//**************************************************************************************************//
({
    init : function(component, event, helper) {
        var action=component.get("c.getObjectNames");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var list=response.getReturnValue();
                component.set("v.ObjectList",list);
                console.log(list);
                console.log('success');
            }
            else{
                console.log('Error');
            }
        });
        $A.enqueueAction(action);
        
    },
    selectObject1:function(component, event, helper){
        var action=component.get("c.getFields");
        var params=component.get("v.objectSelected");
        alert('params');
        action.setParams({"selectedObject":params});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result = response.getReturnValue();
                var plValues = [];
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.fieldList", plValues);
            }
            
        });
        $A.enqueueAction(action);
    },
    handleGenreChange:function(component, event, helper){
        var Action =component.get("c.getQuerryAPI");
        var param1=component.get("v.selectedFieldList");
        var param2=component.get("v.objectSelected");
        Action.setParams({"selectfield":param1 , "userObj":param2});
        Action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result = response.getReturnValue();
                alert(JSON.stringify(result.sobjectlist));
                var arr = [];
                for (var i = 0; i <result.labels.length ; i++) {
                    arr.push({ label:result.labels[i], fieldName:result.Names[i], type:result.Types[i]});
                }
                alert(JSON.stringify(arr));
                component.set("v.columns",arr);
                component.set("v.Data",result.sobjectlist);
                component.set("v.fieldName",result.Names);
                component.set("v.control", "true");
            }
            else{
                console.log('error wrapeer');
            }
        });
        $A.enqueueAction(Action);
        component.set('v.maxRowSelection', 1);
        component.set('v.isButtonDisabled', true);
    },
    downloadCsv : function(component,event,helper){
        var stockData = component.find('selectedRows').getSelectedRows();
        var fieldList=component.get("v.fieldName");
        var selectedObject=component.get("v.objectSelected");
        var csv = helper.convertArrayOfObjectsToCSV(component,stockData,fieldList);
        if (csv == null){return;}
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self';
        hiddenElement.download = 'DataFrom'+selectedObject+'.csv';
        document.body.appendChild(hiddenElement);
        hiddenElement.click();
        console.log('download success');
    },
    handleUploadFinished: function (component,event,helper) {
        var uploadedFiles = event.getParam("files");
        alert(JSON.stringify(uploadedFiles));
        console.log(uploadedFiles);
        console.log(files);
        alert("Files uploaded : " + uploadedFiles.length);
        uploadedFiles.forEach(file => console.log(file.name));
        var data = $.csv.toObjects(uploadedFiles);
        alert('data===='+data);
    }
    
    
    
})