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

    // public extractor methods ------------------------------------------------------------

    // I've considered using Interpretter Pattern to reduce code redundancy.
    // At some later stage (e.g. if there were additional extraction methods), it would probably make sense to do so.
    // However, currently (2018-11-1), the amount of boiler-plate code, the limited amount of reuse,
    // and the performance hit for instantiating objects, suggest it would be over-engineered for the present requirements.

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

    // private match methods ------------------------------------------------------------

    private Boolean hasMatchingAnything(STCE_Library.Book book, String searchTerm) {
        return this.hasMatchingTitle(book, searchTerm)
                || this.hasMatchingAuthor(book, searchTerm)
                || this.hasMatchingId(book, searchTerm);
    }

    private Boolean hasMatchingTitle(STCE_Library.Book book, String searchTerm) {
        return this.nonBlankCaseInsensitiveContains(book.title, searchTerm);
    }

    private Boolean hasMatchingAuthor(STCE_Library.Book book, String searchTerm) {
        return this.nonBlankCaseInsensitiveContains(book.by_statement, searchTerm)
                || this.hasMatchingAuthor(book.authors, searchTerm);
    }

    private Boolean hasMatchingAuthor(List<STCE_Library.Subject_places> authorList, String searchTerm) {
        if (authorList == null) {
            return false;
        }

        for(STCE_Library.Subject_places author : authorList) {
            if (this.nonBlankCaseInsensitiveContains(author.name, searchTerm)) {
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
            if (this.nonBlankCaseInsensitiveContains(openLibraryId, searchTerm)) {
                return true;
            }
        }
        return false;
    }

    private Boolean nonBlankCaseInsensitiveContains(String target, String searchTerm) {
        return !String.isBlank(target)
                && target.toLowerCase().contains(searchTerm);
    }
}