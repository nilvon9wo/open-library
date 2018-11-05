public virtual class STCE_BookFinder {
    @TestVisible
    protected STCE_BookFinder() {
    }

    private static STCE_BookFinder INSTANCE;

    public static STCE_BookFinder getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new STCE_BookFinder();
        }
        return INSTANCE;
    }

    @TestVisible private static final String OPEN_LIBRARY_ID_PREFIX = 'OLID:';

    // public extractor methods ------------------------------------------------------------

    // An alternative solution would be to pass in Map<String, STCE_Library.Book> booksByPrefixedOlidMap
    // instead of List<STCE_Library.Book> bookList, in which case we could check the keys for the openLibraryId.
    // While this would reduce iteration over the for loop for some queries, it would be worse for the many
    // queries for which the search term won't be the openLibraryId.
    public virtual List<STCE_Library.Book> extractMatches(List<STCE_Library.Book> bookList, String searchTerm) {
        String lowerCaseSearchTerm = searchTerm.toLowerCase();
        List<STCE_Library.Book> matchingBookList = new List<STCE_Library.Book>();
        for (STCE_Library.Book book : bookList) {
            if (this.hasMatchingAnything(book, lowerCaseSearchTerm)) {
                matchingBookList.add(book);
            }
        }
        return matchingBookList;
    }

    public virtual STCE_Library.Book extractMatchesById(
            Map<String, STCE_Library.Book> booksByPrefixedOlidMap, String openLibraryId
    ) {
        String prefixedOlid = OPEN_LIBRARY_ID_PREFIX + openLibraryId;

        if (booksByPrefixedOlidMap.keySet().contains(prefixedOlid)) {
            return booksByPrefixedOlidMap.get(prefixedOlid);
        }

        List<STCE_Library.Book> bookList = this.extractMatchesById(booksByPrefixedOlidMap.values(), openLibraryId);
        return (!bookList.isEmpty())
                ? bookList[0]
                : null;
    }

    // I've considered using Interpretter Pattern to reduce code redundancy (see extractMatches).
    // At some later stage (e.g. if there were additional extraction methods), it would probably make sense to do so.
    // However, currently (2018-11-1), the amount of boiler-plate code, the limited amount of reuse, and
    // the performance hit for instantiating objects, suggest it would be over-engineered for the present requirements.
    @TestVisible
    private List<STCE_Library.Book> extractMatchesById(List<STCE_Library.Book> bookList, String searchTerm) {
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

    @TestVisible
    private Boolean hasMatchingAnything(STCE_Library.Book book, String lowerCaseSearchTerm) {
        return this.hasMatchingTitle(book, lowerCaseSearchTerm)
                || this.hasMatchingAuthor(book, lowerCaseSearchTerm)
                || this.hasMatchingId(book, lowerCaseSearchTerm);
    }

    @TestVisible
    private Boolean hasMatchingTitle(STCE_Library.Book book, String lowerCaseSearchTerm) {
        return this.nonBlankCaseInsensitiveContains(book.title, lowerCaseSearchTerm);
    }

    @TestVisible
    private Boolean hasMatchingAuthor(STCE_Library.Book book, String lowerCaseSearchTerm) {
        return this.nonBlankCaseInsensitiveContains(book.by_statement, lowerCaseSearchTerm)
                || this.hasMatchingAuthor(book.authors, lowerCaseSearchTerm);
    }

    @TestVisible
    private Boolean hasMatchingAuthor(List<STCE_Library.Subject_places> authorList, String lowerCaseSearchTerm) {
        if (authorList == null) {
            return false;
        }

        for (STCE_Library.Subject_places author : authorList) {
            if (this.nonBlankCaseInsensitiveContains(author.name, lowerCaseSearchTerm)) {
                return true;
            }
        }
        return false;
    }

    @TestVisible
    private Boolean hasMatchingId(STCE_Library.Book book, String lowerCaseSearchTerm) {
        if (book.identifiers == null) {
            return false;
        }

        return this.hasMatchingId(book.identifiers.openlibrary, lowerCaseSearchTerm);
    }

    @TestVisible
    private Boolean hasMatchingId(List<String> openLibraryIdList, String lowerCaseSearchTerm) {
        if (openLibraryIdList == null) {
            return false;
        }

        for (String openLibraryId : openLibraryIdList) {
            if (this.nonBlankCaseInsensitiveContains(openLibraryId, lowerCaseSearchTerm)) {
                return true;
            }
        }
        return false;
    }

    // While it is tempting to convert the search term to lower case here,
    // we would be repeatedly converting the same phrase.
    // So, for efficiency, we rely on that having been done earlier.
    @TestVisible
    private Boolean nonBlankCaseInsensitiveContains(String target, String lowerCaseSearchTerm) {
        return !String.isBlank(target)
                && target.toLowerCase().contains(lowerCaseSearchTerm);
    }
}