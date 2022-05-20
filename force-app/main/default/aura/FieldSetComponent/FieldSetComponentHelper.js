({
    /*
     * @Description: - Create a Map and put all the inputtype 
     * : - with attribute and then use this map while creating the fieldsets.
     * Available inputs for "lightning:input" are below
     * checkbox, date, datetime, email, file, password, search, tel, url, number, radio, and toggle
     */ 
    configMap: {
        "string": { 
            componentDef: "lightning:input", 
            attributes: { 
                "class" : "slds-input container",
            } 
        },
        "checkbox": { 
            componentDef: "lightning:input", 
            attributes: { 
                "class" : "slds-checkbox__label"
            } 
        },
        "button" : {
            componentDef : "lightning:button",
            attributes : {
                "variant" : "brand",
                "iconName" : "utility:automate",
                "label" : "Submit Form"
            }
        },
        "picklist" : {
            componentDef : "ui:inputSelect",
            attributes : {
                "class" : "slds-select slds-select_container container"
            }
        },
        "multipicklist" : {
            componentDef : "lightning:dualListbox",
            attributes : {
                "sourceLabel" : "Available Options",
                "selectedLabe" : "Selected Options",
                "readonly" : false
            }
        },
        "textarea" : {
            componentDef : "lightning:textarea",
            attributes : {
                "class" : "slds-input container"
            }
        },
    },
    onInit : function(component, event, helper){
        var getSobject = component.get('c.getsObjects');
        console.log('getSobject'+JSON.stringify(getSobject));
        getSobject.setCallback(this, function(response){
            var state = response.getState();
            console.log('state='+state);
            if(component.isValid() && (state === 'SUCCESS' || state === 'DRAFT')){
                var sObjectList = response.getReturnValue();
                var listOptions = [];
                listOptions.push({
                    label : '--Select One--',
                    value : ''
                });
                for(var i=0; i <sObjectList.length; i++){
                    listOptions.push({
                        label : sObjectList[i].split('####')[1],
                        value : sObjectList[i].split('####')[0]
                    });
                }
                component.set('v.sObjectList', listOptions);
                alert(listOptions);
            }else if(state==='INCOMPLETE'){
                console.log('User is Offline System does not support drafts '
                           + JSON.stringify(response.getError()));
            }else if(state ==='ERROR'){
                console.log('state Error '
                           + JSON.stringify(response.getError()));
            }else{
                
            }
        });
        getSobject.setStorable();
        $A.enqueueAction(getSobject);
    },
    onSelectChange : function(component, event, helper){
        
        var selectedObject = component.find('selectObject').get('v.value');
        var getFieldSet = component.get('c.getFieldSet');
        
        component.set("v.theForm", []);
        
        getFieldSet.setParams({
            "sObjectName" :  selectedObject 
        });
        getFieldSet.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && (state === 'SUCCESS' || state === 'DRAFT')){
                var fieldsSetList = response.getReturnValue();
                var listOptions = [];
                listOptions.push({
                    label : '--Select One--',
                    value : ''
                });
                for(var i=0; i < fieldsSetList.length; i++){
                    listOptions.push({
                        label : fieldsSetList[i].split('####')[1],
                        value : fieldsSetList[i].split('####')[0]
                    });
                }
                component.set('v.fieldSetList', listOptions);
            }else if(state==='INCOMPLETE'){
                console.log('User is Offline System does not support drafts '
                           + JSON.stringify(response.getError()));
            }else if(state ==='ERROR'){
                
            }else{
                
            }
        });
        getFieldSet.setStorable();
        $A.enqueueAction(getFieldSet);
    },
    onFieldSetChange : function(component, event, helper){
        var self = this;
        var selectedObject = component.find('selectObject').get('v.value');
        var selectedfieldSet = component.find('fieldSet').get('v.value');
        
        var FiledSetMember = component.get('c.getFieldSetMember');
        FiledSetMember.setParams({
            "objectName" : selectedObject,
            "fieldSetName" : selectedfieldSet
        });
        FiledSetMember.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && (state === 'SUCCESS' || state === 'DRAFT')){
                var fieldSetMember = JSON.parse(response.getReturnValue());
                self.createForm(component, event, helper, fieldSetMember);
            }else if(state==='INCOMPLETE'){
                console.log('User is Offline System does not support drafts '
                           + JSON.stringify(response.getError()));
            }else if(state ==='ERROR'){
                console.log(response.getError());
            }else{
                
            }
        });
        FiledSetMember.setStorable();
        $A.enqueueAction(FiledSetMember);
    },
    createForm : function(component, event, helper, fieldSetMember){
        // Create a map with availale inputs and according to this use the global map.
        var lightningInputMap = new Map();
        lightningInputMap.set('string','string');
        lightningInputMap.set('checkbox','checkbox');
        lightningInputMap.set('date','date');
        lightningInputMap.set('datetime','datetime');
        lightningInputMap.set('email','email');
        lightningInputMap.set('file','file');
        lightningInputMap.set('password','password');
        lightningInputMap.set('search','search');
        lightningInputMap.set('tel','tel');
        lightningInputMap.set('url','url');
        lightningInputMap.set('number','number');
        lightningInputMap.set('radio','radio');
        
        // list of components to create and put into the component body..
        var inputDesc = [];
        var config = null;
        
        /*
         * parse the FieldSet members and then create the members dynamically 
         * and put those components into the component.
         */ 
        for(var i=0; i < fieldSetMember.length; i++){
            var objectName = component.getReference("v.sObjectName");
            if(lightningInputMap.has(fieldSetMember[i].fieldType.toLowerCase())){
                config = JSON.parse(
                    JSON.stringify(this.configMap['string'])
                ); 
                if(config){
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.type = fieldSetMember[i].fieldType;
                    config.attributes.required = 
                        	fieldSetMember[i].isRequired || fieldSetMember[i].isDBRequired;
                    config.attributes.value = 
                        	component.getReference('v.sObjectName.' + fieldSetMember[i].fieldAPIName);
                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                }
            }else{
                if(fieldSetMember[i].fieldType.toLowerCase() === 'integer'){
                    config = JSON.parse(
                        JSON.stringify(this.configMap['string'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.type = 'number';
                    config.attributes.required = 
                        	fieldSetMember[i].isRequired || fieldSetMember[i].isDBRequired;
                    config.attributes.value = 
                        	component.getReference('v.sObjectName.' + fieldSetMember[i].fieldAPIName);
                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                }else if(fieldSetMember[i].fieldType.toLowerCase() === 'phone'){
                    config = JSON.parse(
                        JSON.stringify(this.configMap['string'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.type = 'tel';
                    config.attributes.required = 
                        	fieldSetMember[i].isRequired || fieldSetMember[i].isDBRequired;
                    config.attributes.value = 
                        	component.getReference('v.sObjectName.' + fieldSetMember[i].fieldAPIName);
                    
                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                }else if(fieldSetMember[i].fieldType.toLowerCase() === 'textarea'){
                    config = JSON.parse(
                        JSON.stringify(this.configMap['textarea'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.name = fieldSetMember[i].fieldLabel;
                    
                    config.attributes.required = 
                        	fieldSetMember[i].isRequired || fieldSetMember[i].isDBRequired;
                    config.attributes.value = 
                        	component.getReference('v.sObjectName.' + fieldSetMember[i].fieldAPIName);
                    
                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                }else if(fieldSetMember[i].fieldType.toLowerCase() === 'picklist'){
                    config = JSON.parse(
                        JSON.stringify(this.configMap['picklist'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.name = fieldSetMember[i].fieldLabel;
                    var pickList = fieldSetMember[i].pickListValues;
                    var options = [];
                    for(var k=0; k<pickList.length; k++){
                        if(pickList[k].active){
                            options.push({
                                value : pickList[k].value,
                                label : pickList[k].label
                            });
                        }
                    }
                    config.attributes.options = options;
                    config.attributes.required = 
                        	fieldSetMember[i].isRequired || fieldSetMember[i].isDBRequired;
                    config.attributes.value = 
                        	component.getReference('v.sObjectName.' + fieldSetMember[i].fieldAPIName);
                    
                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                }else if(fieldSetMember[i].fieldType.toLowerCase() === 'multipicklist'){
                    config = JSON.parse(
                        JSON.stringify(this.configMap['multipicklist'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.name = fieldSetMember[i].fieldLabel;
                    var pickList = fieldSetMember[i].pickListValues;
                    var options = [];
                    for(var k=0; k<pickList.length; k++){
                        if(pickList[k].active){
                            options.push({
                                value : pickList[k].value,
                                label : pickList[k].label
                            });
                        }
                    }
                    config.attributes.options = options;
                    config.attributes.required = 
                        	fieldSetMember[i].isRequired || fieldSetMember[i].isDBRequired;
                    config.attributes.value = 
                        	component.getReference('v.sObjectName.' + fieldSetMember[i].fieldAPIName);
                    /*
                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);*/
                }
            }
        }
        var newConfig = JSON.parse(
            JSON.stringify(this.configMap['button'])
        );
        newConfig.attributes.onclick = component.getReference("c.handlePress");
        
        inputDesc.push([
            newConfig.componentDef,
            newConfig.attributes
        ]);
        
        $A.createComponents(inputDesc,
                            function(components, status, errorMessage){
                                if (status === "SUCCESS") {
                                    var form = [];
                                    for(var j=0; j < components.length; j++){
                                        form.push(components[j]);
                                    }
                                    component.set("v.theForm", form);
                                }else if (status === "INCOMPLETE") {
                                    console.log("No response from server or client is offline.");
                                }else if (status === "ERROR") {
                                    console.log("Error: " + errorMessage);
                                    console.log(errorMessage);
                                }
                            }
          );
    },
    onUpserObject : function(component, event, helper){
        var upsertObject = component.get('c.doUpsertObjects');
        upsertObject.setParams({
            "objectData" :  JSON.stringify(component.get('v.sObjectName'))
        });
        upsertObject.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && (state === 'SUCCESS' || state === 'DRAFT')){
                var upsertedRecord = JSON.parse(response.getReturnValue());
            }else if(state==='INCOMPLETE'){
                console.log('User is Offline System does not support drafts '
                           + JSON.stringify(response.getError()));
            }else if(state ==='ERROR'){
                console.log(response.getError());
            }else{
                console.log('Unknown Error While making DML'
                           + JSON.stringify(response.getError()));
            }
        });
        $A.enqueueAction(upsertObject);
    }
})