({
    init: function(component, event, helper) {
        var action = component.get("c.getObjectName");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var allValues = response.getReturnValue();
                component.set("v.opt", allValues);
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                    errors[0].message);
                    }
                }
                else {
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    callMe: function(component, event, helper)
    {
        
       
        var action = component.get("c.getFieldList");
        var selectedValue= component.find("distance").get("v.value");
        action.setParams({ "selectedSObject" : selectedValue});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var allFieldValues = response.getReturnValue();
                var options=[];
                for (var i = 0; i <allFieldValues.length; i++);
                                            {
                                           
                                            options.push({class: "optionClass", 'label': allFieldValues[i], 'value': allFieldValues[i]});
                                            }
              component.find("FieldsList").set("v.options", options); 
                console.log(options);
                
            }
           
        });
        $A.enqueueAction(action);
    },
    handleClick : function(component, event, helper)
    {
        var param1= component.find("distance").get("v.value");
        var Param2=component.find("fieldsList").get("v.value");
        console.log("The SELECTED VALUES ARE..."+Param2);
        var action = component.get("c.getSelectOptions");
        action.setParams({"selectField" : Param2,"userObj":param1});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                alert('*state*'+state);
                console.log('*state*'+state);
                var result = response.getReturnValue();
                alert('the server side res '+result);
                console.log('*result*'+result);
                alert(JSON.stringify(result.sobjectlist));
                var arr = [];
                for (var i = 0; i <result.labels.length ; i++) {
                    var label=result.labels[i];
                    var Names=result.Names[i];
                    arr.push({ label:label, fieldName:Names, type:result.Types[i]});
                }
                component.set("v.Data",result.sobjectlist);
                component.set("v.columns",arr);
                alert('the columns values are.. '+JSON.stringify(arr));
                console.log('the columns values are.. '+arr);
                console.log('the data values are.. '+result.sobjectlist);
            }
        });
        $A.enqueueAction(action);
    }
})