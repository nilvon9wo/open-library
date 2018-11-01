({
    buyBook: function(component) {
        const book = component.get('v.book');
        const params = {openLibraryId: book.identifiers.openlibrary[0]};
        return $LightningPromiseHelper.ServerApexPromise(component, 'saveBook', params);
    },

    toastSuccess: function(event) {
        return $A.getCallback(bookSaveResult =>
            this.makeToast({
                title : 'Success Message',
                message: `${bookSaveResult.book.Name} has been saved with ${bookSaveResult.book.Id}`,
                type: 'success'
            })
        );
    },

    toastFailure: function(event) {
        return $A.getCallback(errors =>
            this.makeToast({
                title : 'Error Message',
                message: Array.isArray(errors)
                    ? errors.join('; ')
                    : errors,
                type: 'error'
            })
        );
    },

    makeToast: function(params) {
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(Object.assign(params, {
            duration : 5000,
            key : 'info_alt',
            mode : 'pester'
        }));
        toastEvent.fire();
    }
})