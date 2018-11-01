public class STCE_BookFinder {
    private STCE_BookFinder() {
    }

    private static STCE_BookFinder INSTANCE;

    public static STCE_BookFinder getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new STCE_BookFinder();
        }
        return INSTANCE;
    }

    public List<STCE_Library.Book> extractMatches(List<STCE_Library.Book> bookList, String searchTerm) {
        String lowerCaseSearchTerm = searchTerm.toLowerCase();
        List<STCE_Library.Book> matchingBookList = new List<STCE_Library.Book>();
        for (STCE_Library.Book book : bookList) {
            if (this.hasMatchingAnything(book, lowerCaseSearchTerm)) {
                matchingBookList.add(book);
            }
        }
        return matchingBookList;
    }

    // TODO: Consider using Interpretter Pattern to reduce code redundancy.
    public List<STCE_Library.Book> extractMatchesById(List<STCE_Library.Book> bookList, String searchTerm) {
        String lowerCaseSearchTerm = searchTerm.toLowerCase();
        List<STCE_Library.Book> matchingBookList = new List<STCE_Library.Book>();
        for (STCE_Library.Book book : bookList) {
            if (this.hasMatchingId(book, lowerCaseSearchTerm)) {
                matchingBookList.add(book);
            }
        }
        return matchingBookList;
    }

    private Boolean hasMatchingAnything(STCE_Library.Book book, String searchTerm) {
        return this.hasMatchingTitle(book, searchTerm)
                || this.hasMatchingAuthor(book, searchTerm)
                || this.hasMatchingId(book, searchTerm);
    }

    private Boolean hasMatchingTitle(STCE_Library.Book book, String searchTerm) {
        return this.nonBlankContains(book.title, searchTerm);
    }

    private Boolean hasMatchingAuthor(STCE_Library.Book book, String searchTerm) {
        return this.nonBlankContains(book.by_statement, searchTerm)
                || this.hasMatchingAuthor(book.authors, searchTerm);
    }

    private Boolean hasMatchingAuthor(List<STCE_Library.Subject_places> authorList, String searchTerm) {
        if (authorList == null) {
            return false;
        }

        for(STCE_Library.Subject_places author : authorList) {
            if (this.nonBlankContains(author.name, searchTerm)) {
                return true;
            }
        }
        return false;
    }

    private Boolean hasMatchingId(STCE_Library.Book book, String searchTerm) {
        if (book.identifiers == null) {
            return false;
        }

        return this.hasMatchingOpenLibraryIdentifier(book.identifiers.openlibrary, searchTerm);
    }

    private Boolean hasMatchingOpenLibraryIdentifier(List<String> openLibraryIdList, String searchTerm) {
        if (openLibraryIdList == null) {
            return false;
        }

        for(String openLibraryId : openLibraryIdList) {
            if (this.nonBlankContains(openLibraryId, searchTerm)) {
                return true;
            }
        }
        return false;
    }

    private Boolean nonBlankContains(String target, String searchTerm) {
        return !String.isBlank(target)
                && target.toLowerCase().contains(searchTerm);
    }
}