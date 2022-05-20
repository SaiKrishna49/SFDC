({
init: function(component, event, helper) {
    var action = component.get("c.getObjectName");
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {           
            var allValues = response.getReturnValue();
            component.set("v.options", allValues);
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
 }
})