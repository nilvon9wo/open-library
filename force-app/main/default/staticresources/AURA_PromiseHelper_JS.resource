// See: http://bobbuzzard.blogspot.hu/2016/12/javascript-promises-in-lightning_30.html
window.$LightningPromiseHelper = (function(){
    const alterSpinner = function(methodName) {
        return (component) => {
            $A.util[methodName](component.find('spinner'), 'slds-hide');
        };
    };

    const showSpinner = alterSpinner('removeClass');
    const hideSpinner = alterSpinner('addClass');

    const ServerApexPromise = (component, serverMethodName, serverMethodParams = {}) => {
        showSpinner(component);
        const action = component.get('c.' + serverMethodName);
        action.setParams(serverMethodParams);

        return new Promise((resolve, reject) => {
            action.setCallback(this, (response) => {
                hideSpinner(component);
                if (response.getState() === 'SUCCESS') {
                    const body = response.getReturnValue();
                    if (body && body.errors) {
                        reject(body.errors);
                    } else {
                        resolve(body);
                    }
                }
                else {
                    const errors = response.getError();
                    const errorMessage = (errors && errors[0] && errors[0].message)
                        ? 'Error message: ' + errors[0].message
                        : 'Unknown error';
                    reject (errorMessage);
                }
            });
            $A.enqueueAction(action);
        });
    };

    return {
        ServerApexPromise: ServerApexPromise
    };
}());
