({
    handleClick : function (cmp, event) {
        alert("Success");
    },
    init: function (cmp, event, helper) {
        var breadcrumbCollection = [
            {label: 'Parent Entity', name: 'entity' },
            {label: 'Parent Record Name', name: 'record' }
        ];

        cmp.set('v.breadcrumbCollection', breadcrumbCollection);
    },
    navigateTo: function (cmp, event, helper) {
        var name = event.getSource().get('v.name');

        switch(name) {
            case 'entity':
                return alert('Navigating to "Parent Entity"');
            case 'record':
                return alert('Navigating to "Parent Record Name"');
        }
    }
});