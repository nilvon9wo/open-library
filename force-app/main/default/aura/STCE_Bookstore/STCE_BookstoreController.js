({
    doInit: function(component, event, helper) {
        helper.loadBooks(component)
            .then($A.getCallback(helper.setBooklist(component)));
    },

    doSearch: function(component, event, helper) {
         helper.submitFilter(component)
            .then($A.getCallback(helper.setBooklist(component)));
    }
})