public class STCE_BooklistAuraCtrl {
    private STCE_OpenLibraryProxy openLibraryProxy;

    private STCE_BooklistAuraCtrl(STCE_OpenLibraryProxy openLibraryProxy) {
        this.openLibraryProxy = openLibraryProxy;
    }

    public STCE_BooklistAuraCtrl(){
        this(STCE_OpenLibraryProxy.getInstance());
    }

    @AuraEnabled
    public static List<STCE_Library.Book> getBooks() {
        return (new STCE_BooklistAuraCtrl()).getBookList();
    }

    private List<STCE_Library.Book> getBookList() {
        return this.openLibraryProxy.getBooks();
    }
}