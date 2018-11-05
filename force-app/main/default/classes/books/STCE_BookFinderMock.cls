@IsTest
public class STCE_BookFinderMock extends STCE_BookFinder {
    public List<STCE_Library.Book> receivedBookList;
    public String receivedSearchTerm;
    public List<STCE_Library.Book> returnedBookList;
    public override List<STCE_Library.Book> extractMatches(List<STCE_Library.Book> bookList, String searchTerm) {
        this.receivedBookList = bookList;
        this.receivedSearchTerm = searchTerm;
        return this.returnedBookList;
    }

    public Map<String, STCE_Library.Book> receivedBooksByPrefixedOlidMap;
    public String receivedOpenLibraryId;
    public STCE_Library.Book returnedBook;
    public override STCE_Library.Book extractMatchesById(
            Map<String, STCE_Library.Book> booksByPrefixedOlidMap, String openLibraryId
    ) {
        this.receivedBooksByPrefixedOlidMap = booksByPrefixedOlidMap;
        this.receivedOpenLibraryId = openLibraryId;
        return this.returnedBook;
    }
}