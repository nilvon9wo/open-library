public class STCE_BookstoreAuraCtrl {
    private STCE_BookFinder bookFinder;
    private STCE_OpenLibraryProxy openLibraryProxy;

    private STCE_BookstoreAuraCtrl(
            STCE_BookFinder bookFinder,
            STCE_OpenLibraryProxy openLibraryProxy
    ) {
        this.bookFinder = bookFinder;
        this.openLibraryProxy = openLibraryProxy;
    }

    public STCE_BookstoreAuraCtrl(){
        this(STCE_BookFinder.getInstance(), STCE_OpenLibraryProxy.getInstance());
    }

    @AuraEnabled
    public static List<STCE_Library.Book> getBooks(String searchTerm) {
        return (new STCE_BookstoreAuraCtrl()).getBookList(searchTerm);
    }

    private List<STCE_Library.Book> getBookList(String searchTerm) {
        List<STCE_Library.Book> bookList = this.openLibraryProxy.getBooks().values();
        return (String.isBlank(searchTerm))
                ? bookList
                : this.bookFinder.extractMatches(bookList, searchTerm);
    }
}