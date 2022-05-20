({
 doinit : function(component, event, helper) 
    {
        var ConList = component.get("c.RelatedList");
        ConList.setParams
        ({
            recordId: component.get("v.recordId")
        });
        
        ConList.setCallback(this, function(data) 
                           {
                               component.set("v.ContactList", data.getReturnValue());
                           });
        $A.enqueueAction(ConList);
 }
})