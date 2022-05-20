({
    doInit : function(component, event, helper) {
        console.log(component.get('v.sectionObjects'))
        helper.onInit(component, event, helper);
    },
    doSelectChange : function(component, event, helper) {
        helper.onSelectChange(component, event, helper);
    },
    doFieldSetChange : function(component, event, helper) {
        helper.onFieldSetChange(component, event, helper);
    },
    handlePress : function(component, event, helper) {
        var objectName = component.get('v.sObjectName');
        alert(JSON.stringify(objectName));
        helper.onUpserObject(component, event, helper);
    },
})