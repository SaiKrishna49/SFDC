({
	add : function(component, event, helper) 
    {
        var a = component.get("v.aVal");
        var b = component.get("v.bVal");
        var R= parseInt(a)+parseInt(b);
        component.set("v.Result",R);
	},
    sub : function(component, event, helper) {
		var a = component.get("v.aVal");
        var b = component.get("v.bVal");
        var R= parseInt(a)-parseInt(b);
        component.set("v.Result",R);
	},
    mul : function(component, event, helper) {
		var a = component.get("v.aVal");
        var b = component.get("v.bVal");
        var R= a*b;
        component.set("v.Result",R);
	},
    clear : function(component, event, helper) {
		component.set("v.Result","");
        component.set("v.aVal","");
        component.set("v.bVal","");
	}
})