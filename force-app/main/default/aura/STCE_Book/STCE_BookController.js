({
    buy: function(component, event, helper) {
        helper.buyBook(component)
            .then($A.getCallback(helper.toastSuccess(event)))
            .catch($A.getCallback(helper.toastFailure(event)));
    }
})