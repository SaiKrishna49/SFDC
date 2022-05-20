({
	createTableStructure : function(component, event, helper) 
    {
		var culmn =
            [
                {label:"Account Name",fieldname : "Name",type:"Text"},
                {label:"Account Phone",fieldname : "Phone",type:"number"},
                {label:"Account Industry",fieldname:"Industry",type:"text"},
                {label:"Account Fax",fieldname:"Fax",type:"text"},
            ];
                   component.set("v.columns", culmn);
	},
                  
                  searchme: function(component, event, helper)
                  {
                      var serchtxt = component.get("v.SearchText");
                      var action = component.get("c.SearchAcc");
                      action.setParams({"st":serchtxt });
                      action.setCallback(this,function(response)
                       {	
                           var state= response.getState();
                           if(state == 'SUCCESS'){
                               var result = response.getReturnValue();
                               component.set("v.accounts", result);
                           }
                          
                      });
                      $A.enqueueAction(action);
                  }
                  
               
})