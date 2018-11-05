@IsTest
public class STCE_BookstoreAuraCtrlTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

    private static final STCE_BookFinderMock MOCK_BOOK_FINDER = new STCE_BookFinderMock();
    private static final STCE_OpenLibraryProxyMock MOCK_OPEN_LIBRARY_PROXY = new STCE_OpenLibraryProxyMock();
    private static final STCE_BookstoreAuraCtrl CONTROLLER_UNDER_TEST = new STCE_BookstoreAuraCtrl(
            MOCK_BOOK_FINDER, MOCK_OPEN_LIBRARY_PROXY
    );

    private static final String TEST_OPEN_LIBRARY_ID = 'OL24364628M';
    private static final String TEST_TITLE = 'Tail of Two Cities';
    private static final String TEST_AUTHOR = 'Charles Dickens';

    private static final STCE_Library.Book TEST_BOOK = createTestBook();

    @IsTest public static void testGetBookListShouldReturnAllBooksIfNoSearchTerm() {
        // Arrange
        MOCK_OPEN_LIBRARY_PROXY.returnedBooksByIdMap = new Map<String, STCE_Library.Book>{
                TEST_OPEN_LIBRARY_ID => TEST_BOOK
        };

        String testSearchTerm = null;

        // Act
        List<STCE_Library.Book> resultList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultList = CONTROLLER_UNDER_TEST.getBookList(testSearchTerm);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(MOCK_OPEN_LIBRARY_PROXY.returnedBooksByIdMap.values(), resultList);
        System.assert(MOCK_OPEN_LIBRARY_PROXY.wasCalled);
    }


    @IsTest public static void testGetBookListShouldFilterBooksIfSearchTerm()  {
        // Arrange

        MOCK_OPEN_LIBRARY_PROXY.returnedBooksByIdMap = new Map<String, STCE_Library.Book>{
                TEST_OPEN_LIBRARY_ID => TEST_BOOK
        };
        MOCK_BOOK_FINDER.returnedBookList = new List<STCE_Library.Book>{TEST_BOOK};
        String testSearchTerm = TEST_AUTHOR;

        // Act
        List<STCE_Library.Book> resultList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultList = CONTROLLER_UNDER_TEST.getBookList(testSearchTerm);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(MOCK_BOOK_FINDER.returnedBookList, resultList);

        System.assert(MOCK_OPEN_LIBRARY_PROXY.wasCalled);
        System.assertEquals(MOCK_OPEN_LIBRARY_PROXY.returnedBooksByIdMap.values(), MOCK_BOOK_FINDER.receivedBookList);
        System.assertEquals(testSearchTerm, MOCK_BOOK_FINDER.receivedSearchTerm);
    }

    private static STCE_Library.Book createTestBook() {
        STCE_Library.Book TEST_BOOK = new STCE_Library.Book();
        TEST_BOOK.title = TEST_TITLE;

        STCE_Library.Subject_places testLibraryAuthor = new STCE_Library.Subject_places();
        testLibraryAuthor.name = TEST_AUTHOR;
        TEST_BOOK.authors = new List<STCE_Library.Subject_places>{testLibraryAuthor};
        return TEST_BOOK;
    }
}