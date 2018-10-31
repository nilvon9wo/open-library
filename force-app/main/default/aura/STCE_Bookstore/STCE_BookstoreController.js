({
    doInit: function(component, event, helper) {
        helper.loadBooks(component)
            .then($A.getCallback(helper.setBooklist(component)));
    }
})