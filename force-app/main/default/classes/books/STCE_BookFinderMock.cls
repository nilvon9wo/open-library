@IsTest
public class STCE_BookFinderMock extends STCE_BookFinder {
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