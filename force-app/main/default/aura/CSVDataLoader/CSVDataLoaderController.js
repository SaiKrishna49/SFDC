({
    handleUploadFinished : function(component, event, helper) {
        var fileInput = component.find("file").getElement();
        var file = fileInput.files[0];
        if(file) {
            console.log("UPLOADED")
            var reader = new FileReader();
            reader.readAsText(file, 'UTF-8');
            reader.onload = function(evt) {
                var csv = evt.target.result;
                component.set("v.csvString", csv);
            }
        }
    },
    
    handleGetCSV : function(component, event, helper) {
        var csv = component.get("v.csvString");
        if(csv != null) {
            helper.createCSVObject(component, csv);
        }
    },
    CreateRecord: function (component, event, helper) {
        var fileInput = component.find("file").getElement();
        var file = fileInput.files[0];
        //alert(file);
        if (file){
            //console.log("File");
            var reader = new FileReader();
            reader.readAsText(file, "UTF-8");
            reader.onload = function (evt) {
                
                //console.log("EVT FN");
                var csv = evt.target.result;
                //console.log('csv file contains'+ csv);
                var result = helper.CSV2JSON(component,csv);
                //console.log('result = ' + result);
                //console.log('Result = '+JSON.parse(result));
                helper.CreateAccount(component,result);
                
            }
            reader.onerror = function (evt) {
                //console.log("error reading file");
            }
        }
        
    },
    
    cleanData : function(component, event, helper) {
        component.set("v.csvString", null);
        component.set("v.csvObject", null);
    },
    handleImportClick:function(component, event, helper){
        var action= component.get("c.ImportData");
        var olyData=component.get("v.onlyData");
        var arr;
        var accountList=[];
        for(var i=0;i<olyData.length;i++){
            arr=olyData[i].toString().split(',');
            accountList.push({
                "FirstName":arr[0],
                "LastName":arr[1],
                "Email":arr[2]
            })
        }
        action.setParams({
            csvData:JSON.stringify(accountList)
        })
        action.setCallback(this,function(response){
            var state=response.getState();
            if (state==="SUCCESS"){
                console.log('server call was successful');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "type" : "success",
                    "message": "Records Have been sucessfully inserted"
                });
                toastEvent.fire();
                component.set("v.csvString", null);
                component.set("v.csvObject", null);
            }else{
                var errors = response.getError();
                console.log('error while server call');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "type" : "error",
                    "message":errors[0].message
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
    
    
})