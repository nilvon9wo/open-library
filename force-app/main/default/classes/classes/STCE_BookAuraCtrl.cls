public class STCE_BookAuraCtrl {
    private DAO_GenericDml genericDml;
    private STCE_BookFinder bookFinder;
    private STCE_OpenLibraryProxy openLibraryProxy;

    private STCE_BookAuraCtrl(
            DAO_GenericDml genericDml,
            STCE_BookFinder bookFinder,
            STCE_OpenLibraryProxy openLibraryProxy
    ) {
        this.genericDml = genericDml;
        this.bookFinder = bookFinder;
        this.openLibraryProxy = openLibraryProxy;
    }

    public STCE_BookAuraCtrl(){
        this(DAO_GenericDml.getInstance(), STCE_BookFinder.getInstance(), STCE_OpenLibraryProxy.getInstance());
    }

    @AuraEnabled
    public static STCE_BookSaveResult saveBook(String openLibraryId) {
        return (new STCE_BookAuraCtrl()).save(openLibraryId);
    }

    private STCE_BookSaveResult save(String openLibraryId) {
        Book__c book = this.bookFinder
                .extractMatchesById(this.openLibraryProxy.getBooks(), openLibraryId)[0]
                .toSObject();

        // TODO: Validate book exists in library and all data is correct.
        // An alternative solution would be just to return an identifier and then [attempt to] find it.
        // But if/as we are trusting the client, it is more efficient to just let the component return the book.

        // TODO: (Re)consider whether how duplicate books will be stored or otherwise handled.
        // Currently any user can save any book, any number of times.
        // This is inefficient and could lead to data integrity issues.

        Database.SaveResult saveResult;
        try {
            saveResult = this.genericDml.doInsert(new List<Book__c>{book})[0];
        } catch (DmlException ex) {
            return new STCE_BookSaveResult(book, ex);
        }

        return new STCE_BookSaveResult(book, saveResult);
    }
}