({
    
    onInit: function (component, event, helper){
        document.addEventListener("grecaptchaVerified", function(e) {
            component.set('v.recaptchaResponse', e.detail.response);
            let myButton = component.find("myButton");
            myButton.set('v.disabled', false);
        });
        
        document.addEventListener("grecaptchaExpired", function() {
            
            let myButton = component.find( "myButton" );
            myButton.set( 'v.disabled', true );
            
        });
    },
    
    onRender: function ( component, event, helper ) {
        
        document.dispatchEvent(new CustomEvent( "grecaptchaRender", { "detail" : { element: 'recaptchaCheckbox'} } ) );
        
    },
    
    doSubmit: function ( component, event, helper ) {
        
        console.log( 'Inside Submit' );
        event.preventDefault();
        let fields = event.getParam( 'fields' );
        fields = Object.assign( { 'sobjectType': 'Lead' }, fields );
        console.log( 'Fields are ' + JSON.stringify( fields ) );
        let action = component.get( "c.insertRecord" );
        action.setParams( {
            
            record: fields,
            recaptchaResponse: component.get( 'v.recaptchaResponse')
            
        } );        
        action.setCallback( this, function( response ) {
            document.dispatchEvent(new Event( "grecaptchaReset" ) );
            let myButton = component.find( "myButton" );
            myButton.set( 'v.disabled', true );            
            let state = response.getState();
            
            if ( state === "SUCCESS" ) {
                
                let result = response.getReturnValue();
                console.log( 'Result is ' + JSON.stringify( result ) );
                
                if ( result.includes( 'Success' ) ) {
                    
                    let showToast = $A.get( "e.force:showToast" );
                    showToast.setParams( {
                        
                        title : 'Lead Creation',
                        message : 'Lead Submitted Sucessfully.' ,
                        type : 'success',
                        mode : 'dismissible'
                        
                    } );
                    showToast.fire();
                    
                }
                
            } else {
                
                let errors = response.getError();
                if ( errors ) {
                    
                    console.log( errors[ 0 ] );
                    
                }
                    
                let showToast = $A.get( "e.force:showToast" );
                showToast.setParams( {
                    
                    title : 'Lead Creation',
                    message : 'Lead is not Submitted due to some error.' ,
                    type : 'error',
                    mode : 'dismissible'
                    
                } );
                showToast.fire();
                
            }
            
        });
        
        $A.enqueueAction(action);
        
    }
    
})