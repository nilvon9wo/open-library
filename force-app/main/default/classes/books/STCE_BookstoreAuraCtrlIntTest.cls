@IsTest
public class STCE_BookstoreAuraCtrlIntTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

    private static final String TARGET_OPEN_LIBRARY_ID = 'OL24364628M';
    private static final String TARGET_TITLE = 'Tail of Two Cities';
    private static final String TARGET_AUTHOR = 'Charles Dickens';

    private static final String OTHER_OPEN_LIBRARY_ID = 'OL243646282';
    private static final String OTHER_TITLE = 'Tail of Two Countries';
    private static final String OTHER_AUTHOR = 'Charles Dickson';

    private static final String SAMPLE_JSON
            = '{' + createBookJson(TARGET_OPEN_LIBRARY_ID, TARGET_TITLE, TARGET_AUTHOR)
                    + ',' + createBookJson(OTHER_OPEN_LIBRARY_ID, OTHER_TITLE, OTHER_AUTHOR)
                    + '}';

    private static String createBookJson(String openLibraryId, String title, String author) {
        return '"OLID:' + openLibraryId
                + '":{"publishers":[{"name":"S.H. Goetzel"}],"pagination":"368 p. ;",'
                + '"identifiers":{"openlibrary":["' + openLibraryId + '"]},'
                + '"title":"' + title + '",'
                + '"authors":[{"name":"' + author + '"}],'
                + '"url":"https://openlibrary.org/books/' + openLibraryId
                + '/Great_expectations","number_of_pages":368,"cover":{"'
                + 'small":"https://covers.openlibrary.org/b/id/6995592-S.jpg","'
                + 'large":"https://covers.openlibrary.org/b/id/6995592-L.jpg","'
                + 'medium":"https://covers.openlibrary.org/b/id/6995592-M.jpg"},"publish_date":"1863",'
                + '"key":"/books/' + openLibraryId
                + '","by_statement":"by ' + author
                + '","publish_places":[{"name":"Mobile"}],"ebooks":[{"formats":{"pdf":{"'
                + 'url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick.pdf"},"epub":{"'
                + 'url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick.epub"},"text":{"'
                + 'url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick_djvu.txt"}},"'
                + 'preview_url":"https://archive.org/details/greatexpectatio00dick","'
                + 'read_url":"https://archive.org/stream/greatexpectatio00dick","availability":"full"}]}';
    }

    @IsTest public static void testGetBooksShouldFilterBooksIfSearchTerm() {
        // Arrange
        HttpResponse testHttpResponse = new HttpResponse();
        testHttpResponse.setBody(SAMPLE_JSON);
        TEST_GenericHttpCalloutMock mockCallout = new TEST_GenericHttpCalloutMock(testHttpResponse);
        Test.setMock(HttpCalloutMock.class, mockCallout);

        String testSearchTerm = TARGET_OPEN_LIBRARY_ID;

        // Act
        List<STCE_Library.Book> resultList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultList = STCE_BookstoreAuraCtrl.getBooks(testSearchTerm);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(1, resultList.size());
        STCE_Library.Book resultBook = resultList[0];

        System.assertEquals(TARGET_OPEN_LIBRARY_ID, resultBook.identifiers.openlibrary[0]);
        System.assertEquals(TARGET_TITLE, resultBook.title);
        System.assertEquals(TARGET_AUTHOR, resultBook.authors[0].name);
    }
}