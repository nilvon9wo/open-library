public class STCE_BookAuraCtrl {
    private F45_DML_GenericDml genericDml;
    private STCE_BookFinder bookFinder;
    private STCE_OpenLibraryProxy openLibraryProxy;

    @TestVisible
    private STCE_BookAuraCtrl(
            F45_DML_GenericDml genericDml,
            STCE_BookFinder bookFinder,
            STCE_OpenLibraryProxy openLibraryProxy
    ) {
        this.genericDml = genericDml;
        this.bookFinder = bookFinder;
        this.openLibraryProxy = openLibraryProxy;
    }

    public STCE_BookAuraCtrl(){
        this(F45_DML_GenericDml.getInstance(), STCE_BookFinder.getInstance(), STCE_OpenLibraryProxy.getInstance());
    }

    @AuraEnabled
    public static STCE_BookSaveResult saveBook(String openLibraryId) {
        return (new STCE_BookAuraCtrl()).save(openLibraryId);
    }

    @TestVisible
    private STCE_BookSaveResult save(String openLibraryId) {
        Book__c book = this.bookFinder.extractMatchesById(this.openLibraryProxy.getBooks(), openLibraryId)
                .toSObject();

        // TODO: (Re)consider whether how duplicate books will be stored or otherwise handled.
        // Currently any user can save any book, any number of times.
        // This is inefficient and could lead to data integrity issues.

        return new STCE_BookSaveResult(
                book,
                this.genericDml.doInsert(new List<Book__c>{book}, F45_DML_GenericDml.NOT_ALL_OR_NONE)
                        .getResultWrapperList()[0]
        );
    }
}