({
    doinit : function(component, event, helper) {
        var action = component.get('c.fetchAcc');
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                console.log("allValues--->>> " + allValues);
                component.set('v.accData', allValues);
            }
            else if(state === "ERROR") {
                var errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log("Error Message: " + errors[0].message);
                    }
                }
                else{
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    showCon : function(component, event, helper){
        component.set("v.show",true);
        var idx = event.target.getAttribute('data-index');
        console.log('idx---->>> ' + idx);
        var rowRecord = component.get("v.accData")[idx];
        console.log('rowRecord---->>> ' + JSON.stringify(rowRecord));
        var action = component.get('c.fetchCon');
        action.setParams({recordId : rowRecord.Id});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                console.log("allValues--->>> " + JSON.stringify(allValues));
                component.set('v.conData', allValues);
            }
            else if(state === "ERROR") {
                var errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log("Error Message: " + errors[0].message);
                    }
                }
                else{
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})