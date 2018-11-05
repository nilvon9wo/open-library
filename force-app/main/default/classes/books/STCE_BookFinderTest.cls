@IsTest
public class STCE_BookFinderTest {
    private static final STCE_BookFinder FINDER_UNDER_TEST = STCE_BookFinder.getInstance();

    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

    private static final STCE_Library.Book TEST_BOOK = new STCE_Library.Book();

    private static final String TEST_TITLE = 'Tail of Two Cities';
    private static final String TEST_TITLE_LOWERCASE = TEST_TITLE.toLowerCase();
    private static final String DIFFERENT_TITLE = 'Another World';

    private static final String TEST_AUTHOR = 'Charles Dickens';
    private static final String TEST_AUTHOR_LOWERCASE = TEST_AUTHOR.toLowerCase();
    private static final String DIFFERENT_AUTHOR = 'John Doe';

    private static final String TEST_OPEN_LIBRARY_ID = 'OL24364628M';
    private static final String TEST_OPEN_LIBRARY_ID_LOWERCASE = TEST_OPEN_LIBRARY_ID.toLowerCase();
    private static final String DIFFERENT_OLID = '32432424';

    private static final String TEST_ARBITRARY = 'Whatever';
    private static final String TEST_ARBITRARY_LOWERCASE = TEST_ARBITRARY.toLowerCase();

    private static final Boolean IS_MATCHING = true;
    private static final Boolean NOT_MATCHING = false;

    // extractMatches tests ---------------------------------------------------------------------------------------

    @IsTest public static void testExtractMatchesShouldReturnListOfMatchingBooks() {
        // Arrange
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                TEST_OPEN_LIBRARY_ID
        };
        List<STCE_Library.Book> testBookList = new List<STCE_Library.Book>{
                TEST_BOOK
        };

        // Act
        List<STCE_Library.Book> resultList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultList = FINDER_UNDER_TEST.extractMatches(testBookList, TEST_OPEN_LIBRARY_ID_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(1, resultList.size());
        System.assertEquals(TEST_BOOK, resultList[0]);
    }

    @IsTest public static void testExtractMatchesShouldReturnEmptyListIfNoMatchingBooks() {
        // Arrange
        List<STCE_Library.Book> testBookList = new List<STCE_Library.Book>{
                TEST_BOOK
        };

        // Act
        List<STCE_Library.Book> resultList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultList = FINDER_UNDER_TEST.extractMatches(testBookList, TEST_OPEN_LIBRARY_ID_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assert(resultList.isEmpty());
    }

    // extractMatchesById tests ---------------------------------------------------------------------------------------

    @IsTest public static void testExtractMatchesByIdShouldReturnBookFromMapKeyWhenPossible() {
        // Arrange
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                TEST_OPEN_LIBRARY_ID
        };
        Map<String, STCE_Library.Book> testBooksByPrefixedOlidMap = new Map<String, STCE_Library.Book>{
                STCE_BookFinder.OPEN_LIBRARY_ID_PREFIX + TEST_OPEN_LIBRARY_ID => TEST_BOOK
        };

        // Act
        STCE_Library.Book resulBook;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resulBook = FINDER_UNDER_TEST.extractMatchesById(testBooksByPrefixedOlidMap, TEST_OPEN_LIBRARY_ID);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(TEST_BOOK, resulBook);
    }

    @IsTest public static void testExtractMatchesByIdShouldReturnBookFromMapValuesWhenNoKeyMatches() {
        // Arrange
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                TEST_OPEN_LIBRARY_ID
        };
        Map<String, STCE_Library.Book> testBooksByPrefixedOlidMap = new Map<String, STCE_Library.Book>{
                DIFFERENT_OLID => TEST_BOOK
        };

        // Act
        STCE_Library.Book resulBook;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resulBook = FINDER_UNDER_TEST.extractMatchesById(testBooksByPrefixedOlidMap, TEST_OPEN_LIBRARY_ID);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(TEST_BOOK, resulBook);
    }

    @IsTest public static void testExtractMatchesByIdShouldReturnNullFromMapValuesWhenNoMatches() {
        // Arrange
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                DIFFERENT_OLID
        };
        Map<String, STCE_Library.Book> testBooksByPrefixedOlidMap = new Map<String, STCE_Library.Book>{
                DIFFERENT_OLID => TEST_BOOK
        };

        // Act
        STCE_Library.Book resulBook;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resulBook = FINDER_UNDER_TEST.extractMatchesById(testBooksByPrefixedOlidMap, TEST_OPEN_LIBRARY_ID);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(null, resulBook);
    }

    @IsTest public static void testExtractMatchesByIdShouldReturnListOfMatchingBooks() {
        // Arrange
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                TEST_OPEN_LIBRARY_ID
        };
        List<STCE_Library.Book> testBookList = new List<STCE_Library.Book>{
                TEST_BOOK
        };

        // Act
        List<STCE_Library.Book> resultList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultList = FINDER_UNDER_TEST.extractMatchesById(testBookList, TEST_OPEN_LIBRARY_ID_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(1, resultList.size());
        System.assertEquals(TEST_BOOK, resultList[0]);
    }

    @IsTest public static void testExtractMatchesByIdShouldReturnEmptyListIfNoMatchingBooks() {
        // Arrange
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                DIFFERENT_OLID
        };
        List<STCE_Library.Book> testBookList = new List<STCE_Library.Book>{
                TEST_BOOK
        };

        // Act
        List<STCE_Library.Book> resultList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultList = FINDER_UNDER_TEST.extractMatchesById(testBookList, TEST_OPEN_LIBRARY_ID_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assert(resultList.isEmpty());
    }

    // hasMatchingAnything tests ---------------------------------------------------------------------------------------

    @IsTest public static void testHasMatchingAnythingShouldReturnTrueIfTitleMatches() {/* TODO */
        TEST_BOOK.title = TEST_ARBITRARY;
        testHasMatchingAnything(TEST_BOOK, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingAnythingShouldReturnTrueIfAuthorMatches() {/* TODO */
        TEST_BOOK.by_statement = TEST_ARBITRARY;
        testHasMatchingAnything(TEST_BOOK, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingAnythingShouldReturnTrueIfIdMatches() {
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                TEST_ARBITRARY
        };
        testHasMatchingAnything(TEST_BOOK, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingAnythingShouldReturnFalseIfNoMatches() {
        testHasMatchingAnything(TEST_BOOK, NOT_MATCHING);
    }

    private static void testHasMatchingAnything(STCE_Library.Book testBook, Boolean expectation) {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.hasMatchingAnything(testBook, TEST_ARBITRARY_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }

    // hasMatchingTitle tests ---------------------------------------------------------------------------------------

    @IsTest public static void testHasMatchingTitleShouldReturnTrueIfTitleMatches() {
        TEST_BOOK.title = TEST_TITLE;
        testHasMatchingTitle(TEST_BOOK, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingTitleShouldReturnFalseIfTitleDoesntMatch() {
        TEST_BOOK.title = DIFFERENT_TITLE;
        testHasMatchingTitle(TEST_BOOK, NOT_MATCHING);
    }

    private static void testHasMatchingTitle(STCE_Library.Book testBook, Boolean expectation) {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.hasMatchingTitle(testBook, TEST_TITLE_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }
    // hasMatchingAuthor tests ---------------------------------------------------------------------------------------

    @IsTest public static void testHasMatchingAuthorShouldReturnTrueIfAuthorMatchesByStatement() {
        TEST_BOOK.by_statement = TEST_AUTHOR;
        testHasMatchingAuthor(TEST_BOOK, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingAuthorShouldReturnTrueIfAuthorInBookAuthorList() {
        STCE_Library.Subject_places testAuthor = new STCE_Library.Subject_places();
        testAuthor.name = TEST_AUTHOR;
        TEST_BOOK.authors = new List<STCE_Library.Subject_places>{
                testAuthor
        };
        testHasMatchingAuthor(TEST_BOOK, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingAuthorShouldReturnFalseIfAuthorDoesntMatch() {
        STCE_Library.Subject_places testAuthor = new STCE_Library.Subject_places();
        testAuthor.name = DIFFERENT_AUTHOR;
        TEST_BOOK.authors = new List<STCE_Library.Subject_places>{
                testAuthor
        };
        testHasMatchingAuthor(TEST_BOOK, NOT_MATCHING);
    }

    private static void testHasMatchingAuthor(STCE_Library.Book testBook, Boolean expectation) {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.hasMatchingAuthor(testBook, TEST_AUTHOR_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }

    @IsTest public static void testHasMatchingAuthorShouldReturnTrueIfAuthorIsInAuthorList() {
        STCE_Library.Subject_places testAuthor = new STCE_Library.Subject_places();
        testAuthor.name = TEST_AUTHOR;
        List<STCE_Library.Subject_places> testAuthorList = new List<STCE_Library.Subject_places>{
                testAuthor
        };
        testHasMatchingAuthor(testAuthorList, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingAuthorShouldReturnFalseIfAuthorNotInAuthorList() {
        STCE_Library.Subject_places testAuthor = new STCE_Library.Subject_places();
        testAuthor.name = DIFFERENT_AUTHOR;
        List<STCE_Library.Subject_places> testAuthorList = new List<STCE_Library.Subject_places>{
                testAuthor
        };
        testHasMatchingAuthor(testAuthorList, NOT_MATCHING);
    }

    @IsTest public static void testHasMatchingAuthorShouldReturnFalseIfAuthorListEmpty() {
        List<STCE_Library.Subject_places> testAuthorList = new List<STCE_Library.Subject_places>();
        testHasMatchingAuthor(testAuthorList, NOT_MATCHING);
    }

    @IsTest public static void testHasMatchingAuthorShouldReturnFalseIfAuthorListIsNull() {
        List<STCE_Library.Subject_places> testAuthorList = null;
        testHasMatchingAuthor(testAuthorList, NOT_MATCHING);
    }

    private static void testHasMatchingAuthor(List<STCE_Library.Subject_places> testAuthorList, Boolean expectation) {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.hasMatchingAuthor(testAuthorList, TEST_AUTHOR_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }

    // hasMatchingId tests ---------------------------------------------------------------------------------------

    @IsTest public static void testHasMatchingIdShouldReturnTrueIfBookIdentifiersOpenLibraryListContainsId() {
        TEST_BOOK.identifiers = new STCE_Library.Identifiers();
        TEST_BOOK.identifiers.openlibrary = new List<String>{
                TEST_OPEN_LIBRARY_ID
        };
        testHasMatchingId(TEST_BOOK, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingIdShouldReturnFalseIfBookHasNoIdentifiers() {
        TEST_BOOK.identifiers = null;
        testHasMatchingId(TEST_BOOK, NOT_MATCHING);
    }

    private static void testHasMatchingId(STCE_Library.Book testBook, Boolean expectation) {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.hasMatchingId(testBook, TEST_OPEN_LIBRARY_ID_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }

    @IsTest public static void testHasMatchingIdShouldReturnTrueIfOpenLibraryListContainsId() {
        List<String> testOpenLibraryIdList = new List<String>{
                TEST_OPEN_LIBRARY_ID
        };
        testHasMatchingId(testOpenLibraryIdList, IS_MATCHING);
    }

    @IsTest public static void testHasMatchingIdShouldReturnFalseIfOpenLibraryListDoesNotContainId() {
        List<String> testOpenLibraryIdList = new List<String>{
                DIFFERENT_OLID
        };
        testHasMatchingId(testOpenLibraryIdList, NOT_MATCHING);
    }

    @IsTest public static void testHasMatchingIdShouldReturnFalseIfOpenLibraryListEmpty() {
        List<String> testOpenLibraryIdList = new List<String>();
        testHasMatchingId(testOpenLibraryIdList, NOT_MATCHING);
    }

    @IsTest public static void testHasMatchingIdShouldReturnFalseIfOpenLibraryListIsNull() {
        List<String> testOpenLibraryIdList = null;
        testHasMatchingId(testOpenLibraryIdList, NOT_MATCHING);
    }

    private static void testHasMatchingId(List<String> testOpenLibraryIdList, Boolean expectation) {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.hasMatchingId(testOpenLibraryIdList, TEST_OPEN_LIBRARY_ID_LOWERCASE);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }

    // nonBlankCaseInsensitiveContains Tests --------------------------------------------------------------------------

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnFalseIfTargetIsNull() {
        testNonBlankCaseInsensitiveContains(null, TEST_TITLE_LOWERCASE, NOT_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnFalseIfTargetIsEmpty() {
        testNonBlankCaseInsensitiveContains('', TEST_TITLE_LOWERCASE, NOT_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnTrueIfTargetIsLowerCaseAndTermIsMatchingLowerCase() {
        testNonBlankCaseInsensitiveContains(TEST_TITLE.toLowerCase(), TEST_TITLE_LOWERCASE, IS_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnTrueIfTargetIsUpperCaseAndTermIsMatchingLowerCase() {
        testNonBlankCaseInsensitiveContains(TEST_TITLE.toUpperCase(), TEST_TITLE_LOWERCASE, IS_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnFalseIfTargetDoesNotMatch() {
        testNonBlankCaseInsensitiveContains(TEST_AUTHOR, TEST_TITLE_LOWERCASE, NOT_MATCHING);
    }

    private static void testNonBlankCaseInsensitiveContains(String testTarget, String testLowerCaseSearchTerm, Boolean expectation) {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.nonBlankCaseInsensitiveContains(testTarget, testLowerCaseSearchTerm);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }
}