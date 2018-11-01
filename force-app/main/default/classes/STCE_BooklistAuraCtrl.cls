public class STCE_BooklistAuraCtrl {
    private DAO_GenericDml genericDml;
    private STCE_BookFinder bookFinder;
    private STCE_OpenLibraryProxy openLibraryProxy;

    private STCE_BooklistAuraCtrl(
            DAO_GenericDml genericDml,
            STCE_BookFinder bookFinder,
            STCE_OpenLibraryProxy openLibraryProxy
    ) {
        this.genericDml = genericDml;
        this.bookFinder = bookFinder;
        this.openLibraryProxy = openLibraryProxy;
    }

    public STCE_BooklistAuraCtrl(){
        this(DAO_GenericDml.getInstance(), STCE_BookFinder.getInstance(), STCE_OpenLibraryProxy.getInstance());
    }

    @AuraEnabled
    public static List<STCE_Library.Book> getBooks(String searchTerm) {
        return (new STCE_BooklistAuraCtrl()).getBookList(searchTerm);
    }

    private List<STCE_Library.Book> getBookList(String searchTerm) {
        List<STCE_Library.Book> bookList = this.openLibraryProxy.getBooks();
        return (String.isBlank(searchTerm))
                ? bookList
                : this.bookFinder.extractMatches(bookList, searchTerm);
    }

    @AuraEnabled
    public static STCE_BookSaveResult save(STCE_Library.Book book) {
        return (new STCE_BooklistAuraCtrl()).saveBook(book);
    }

    private STCE_BookSaveResult saveBook(STCE_Library.Book libraryBook) {
        Book__c book = libraryBook.toSObject();
        List<Book__c> bookList = new List<Book__c>{book};

        Database.SaveResult saveResult;
        try {
            saveResult = this.genericDml.doInsert(bookList)[0];
        } catch (DmlException ex) {
            return new STCE_BookSaveResult(book, ex);
        }

        return new STCE_BookSaveResult(book, saveResult);
    }
}