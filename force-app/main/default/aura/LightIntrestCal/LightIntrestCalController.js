({
	calulate : function(component, event, helper) 
    {
	    var a = component.get("v.principle");
        var b = component.get("v.Time");
        var c = component.get("v.rateOfIntrest");
        var R = (parseInt(a)*parseInt(b)*parseInt(c))/100;
        component.set("v.result", R);
        console.log(R);
        var T = parseInt(a) + parseInt(R);
        component.set("v.TotalAmmount", T);
        console.log(T);
	},
    clear : function(component, event, helper) 
    {
        component.set("v.result", "");
        component.set("v.principle", "");
        component.set("v.Time", "");
        component.set("v.rateOfIntrest", "");
        component.set("v.TotalAmmount", " ");
	}
    
})