({
    loadBooks: function(component) {
        return $LightningPromiseHelper.ServerApexPromise(component, 'getBooks');
    },

    submitFilter: function(component) {
        return $LightningPromiseHelper.ServerApexPromise(component, 'getBooks', {searchTerm: component.get('v.query')});
    },

    setBooklist: function(component) {
        return $A.getCallback(bookList => component.set('v.booklist', bookList));
    }
})