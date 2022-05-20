({
    init: function (component, event, helper) {
        component.set('v.columns', [
            {label: 'name', fieldName: 'Name', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'},
            
        ]);
            
            
        var action=component.get('c.getOpportunities');
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
            alert(rows.length)
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    if (row.Account) row.AccountName = row.Account.Name;
                }
                component.set("v.data", rows);
                
            }
        });
        $A.enqueueAction(action);    

		
    },
      
})