@IsTest
public class STCE_BookAuraCtrlTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

    private static final F45_DML_GenericDmlMock MOCK_GENERIC_DML = new F45_DML_GenericDmlMock();
    private static final STCE_BookFinderMock MOCK_BOOK_FINDER = new STCE_BookFinderMock();
    private static final STCE_OpenLibraryProxyMock MOCK_OPEN_LIBRARY_PROXY = new STCE_OpenLibraryProxyMock();
    private static final STCE_BookAuraCtrl CONTROLLER_UNDER_TEST = new STCE_BookAuraCtrl(
            MOCK_GENERIC_DML, MOCK_BOOK_FINDER, MOCK_OPEN_LIBRARY_PROXY
    );

    private static final String TEST_OPEN_LIBRARY_ID = 'OL24364628M';
    private static final String TEST_TITLE = 'Tail of Two Cities';
    private static final String TEST_AUTHOR = 'Charles Dickens';

    @IsTest public static void testSaveShouldSaveBookWithCoorespondingOpenLibraryId() {
        // Arrange
        prepareMocks(createTestBook());

        // Act
        STCE_BookSaveResult result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = CONTROLLER_UNDER_TEST.save(TEST_OPEN_LIBRARY_ID);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(TEST_TITLE, result.book.Name);
        System.assertEquals(TEST_AUTHOR, result.book.Author__c);
        System.assertEquals(null, result.errors);

        System.assert(MOCK_OPEN_LIBRARY_PROXY.wasCalled);
        System.assertEquals(TEST_OPEN_LIBRARY_ID, MOCK_BOOK_FINDER.receivedOpenLibraryId);
        System.assertEquals(MOCK_OPEN_LIBRARY_PROXY.returnedBooksByIdMap, MOCK_BOOK_FINDER.receivedBooksByPrefixedOlidMap);
    }

    private static STCE_Library.Book createTestBook() {
        STCE_Library.Book TEST_BOOK = new STCE_Library.Book();
        TEST_BOOK.title = TEST_TITLE;

        STCE_Library.Subject_places testLibraryAuthor = new STCE_Library.Subject_places();
        testLibraryAuthor.name = TEST_AUTHOR;
        TEST_BOOK.authors = new List<STCE_Library.Subject_places>{
                testLibraryAuthor
        };
        return TEST_BOOK;
    }

    private static void prepareMocks(STCE_Library.Book testBook) {
        MOCK_OPEN_LIBRARY_PROXY.returnedBooksByIdMap = new Map<String, STCE_Library.Book>{
                TEST_OPEN_LIBRARY_ID => testBook
        };
        MOCK_BOOK_FINDER.returnedBook = testBook;

        F45_DML_SaveResultWrapper testSaveResult = new F45_DML_SaveResultWrapper();
        testSaveResult.wasSuccess = true;
        F45_DML_SaveResultListWrapper testSaveResultList = new F45_DML_SaveResultListWrapper(new List<Database.SaveResult>());
        testSaveResultList.resultWrapperList = new List<F45_DML_SaveResultWrapper>{
                testSaveResult
        };
        MOCK_GENERIC_DML.dmlResultListWrapperList = new List<F45_DML_ResultListWrapperIntf>{
                testSaveResultList
        };
    }
}