({
    loadBooks: function(component) {
        return $LightningPromiseHelper.ServerApexPromise(component, 'getBooks');
    }, 

    setBooklist: function(component) {
        return $A.getCallback(bookList => component.set('v.booklist', bookList));
    }
})