/**<!---**************************************************************************************************
*** Controller Name         : DisplayObjectsComponentController
*** Class Description       :  This is the controller for component is used to display all objects and fields of selected object fields.
*** Author                  : Krishna
*** Class Created Date      : 17-Nov-2021
**********************************************************************************************-->*/
({ 
    doInit: function(component, event, helper) 
    { 
        var action = component.get("c.allObjectsList"); 
        var opts=[]; 
        action.setCallback(this, function(response) 
                           { 
                               var state = response.getState(); 
                               console.log(response.getReturnValue()); 
                               if (state == "SUCCESS") 
                               { 
                                   var allValues = response.getReturnValue(); 
                                   for (var i = 0; i < allValues.length; i++) 
                                   { 
                                       opts.push({ class: "optionClass", label: allValues[i], value: allValues[i] }); 
                                   } 
                                   component.find("SobjectList").set("v.options", opts); 
                               } else 
                               { 
                                   console.log("Failed with state: " + state); 
                               } 
                           }); 
        $A.enqueueAction(action); 
    }, 
    getfields: function(component, event, helper) 
    { 
        var action = component.get("c.allFieldsList"); 
        var userObj=component.find("SobjectList").get("v.value"); 
        action.setParams({ "flds": userObj }); 
        var opts=[]; 
        action.setCallback(this, function(response) 
                           { var state = response.getState(); 
                            console.log(response.getReturnValue()); 
                            if (state == "SUCCESS") 
                            { 
                                var allValues = response.getReturnValue(); 
                                for (var i = 0; i < allValues.length; i++) 
                                { 
                                    opts.push(
                                        { class: "optionClass", label: allValues[i], value: allValues[i] }
                                    );
                                }
                                component.find("FieldsList").set("v.options", opts); 
                            } else 
                            { 
                                console.log("Failed with state: " + state); 
                            } 
                           });
        $A.enqueueAction(action); 
    },
    Query : function(component, event, helper){
        var action = component.get("c.getQuerryAPI");
        var selectfield = component.find("FieldsList").get("v.value");
        component.set("v.selectedfield",selectfield);
        var userObj=component.find("SobjectList").get("v.value");
        action.setParams({ 
            "selectfield" : selectfield,
            "userObj"  : userObj
        });
        action.setCallback(this, function(response){ 
            var state = response.getState(); 
            
            
            console.log(response.getReturnValue()); 
            if (state == "SUCCESS") {  
                console.log("state"+ state);
                var column=[];
                alert("I length"+ response.getReturnValue().labels.length);
                for(var i=0;i<response.getReturnValue().labels.length;i++){
                    column.push({label:response.getReturnValue().labels[i],
                                 fieldName:response.getReturnValue().APINames[i],
                                 type:response.getReturnValue().Types[i]});
                }
                component.set("v.columns",column);
                component.set("v.data",response.getReturnValue().sobjectlist);
            }
        });
        $A.enqueueAction(action); 
        component.set('v.maxRowSelection', 1);
        component.set('v.isButtonDisabled', true);
    },
  /*  downloadCsv : function(component,event,helper){
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
    },
    handleUploadFinished: function (cmp, event) {
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : " + uploadedFiles.length);
        uploadedFiles.forEach(file => console.log(file.name));
        var data = $.csv.toObjects(uploadedFiles);
        alert('data===='+data);
    }*/
})