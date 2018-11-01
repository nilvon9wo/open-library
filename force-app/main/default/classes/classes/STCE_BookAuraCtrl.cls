public class STCE_BookAuraCtrl {
    private DAO_GenericDml genericDml;

    private STCE_BookAuraCtrl(DAO_GenericDml genericDml) {
        this.genericDml = genericDml;
    }

    public STCE_BookAuraCtrl(){
        this(DAO_GenericDml.getInstance());
    }

    @AuraEnabled
    public static STCE_BookSaveResult save(STCE_Library.Book book) {
        return (new STCE_BookAuraCtrl()).saveBook(book);
    }

    private STCE_BookSaveResult saveBook(STCE_Library.Book libraryBook) {
        Book__c book = libraryBook.toSObject();
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