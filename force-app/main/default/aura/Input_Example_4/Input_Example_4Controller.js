({
	calculate : function(component, event, helper) {
        var ammount= component.get("v.ammount");
        var rate= component.get("v.rate");
        var years= component.get("v.years");
        var intrest= (ammount*rate*years)/100;
        console.log('Intrest:'+intrest);
        component.set("v.Intrest",intrest);
		
	}
})