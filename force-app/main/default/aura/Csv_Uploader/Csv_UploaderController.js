({
	onDragOver : function(component, event, helper) {
		event.preventDefault();
	},
    
    onDrop : function(component, event, helper) {
		event.stopPropagation();
        event.preventDefault();
        event.dataTransfer.dropEffect='copy';
        var files=event.dataTransfer.files;
        helper.readFile(component,helper,files[0]);
	},
    
    processFileContent : function(component,event,helper){
        helper.saveRecords(component,event);
    },
    
    cancel : function(component,event,helper){
        component.set("v.showMain",true);
    }
})