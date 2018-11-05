@IsTest
public class STCE_BookAuraCtrlIntTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

    private static final STCE_BookAuraCtrl CONTROLLER_UNDER_TEST = new STCE_BookAuraCtrl();

    private static final String TEST_OPEN_LIBRARY_ID = 'OL24364628M';
    private static final String TEST_TITLE = 'Tail of Two Cities';
    private static final String TEST_AUTHOR = 'Charles Dickens';

    private static final String SAMPLE_JSON
            = '{"OLID:' + TEST_OPEN_LIBRARY_ID
                    + '":{"publishers":[{"name":"S.H. Goetzel"}],"pagination":"368 p. ;","identifiers":{"openlibrary":["OL24364628M"]},'
                    + '"title":"' + TEST_TITLE + '",'
                    + '"authors":[{"name":"' + TEST_AUTHOR + '"}],'
                    + '"url":"https://openlibrary.org/books/OL24364628M/Great_expectations","number_of_pages":368,"cover":{"small":"https://covers.openlibrary.org/b/id/6995592-S.jpg","large":"https://covers.openlibrary.org/b/id/6995592-L.jpg","medium":"https://covers.openlibrary.org/b/id/6995592-M.jpg"},"publish_date":"1863","key":"/books/OL24364628M","by_statement":"by Charles Dickens","publish_places":[{"name":"Mobile"}],"ebooks":[{"formats":{"pdf":{"url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick.pdf"},"epub":{"url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick.epub"},"text":{"url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick_djvu.txt"}},"preview_url":"https://archive.org/details/greatexpectatio00dick","read_url":"https://archive.org/stream/greatexpectatio00dick","availability":"full"}]}}';

    @IsTest public static void testSaveBookShouldSaveBookWithCoorespondingOpenLibraryId() {
        // Arrange
        HttpResponse testHttpResponse = new HttpResponse();
        testHttpResponse.setBody(SAMPLE_JSON);
        TEST_GenericHttpCalloutMock mockCallout = new TEST_GenericHttpCalloutMock(testHttpResponse);
        Test.setMock(HttpCalloutMock.class, mockCallout);

        // Act
        STCE_BookSaveResult result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = STCE_BookAuraCtrl.saveBook(TEST_OPEN_LIBRARY_ID);
        }
        Test.stopTest();

        // Assert
        System.assertNotEquals(null, result.book.Id);
        System.assertEquals(TEST_TITLE, result.book.Name);
        System.assertEquals(TEST_AUTHOR, result.book.Author__c);
        System.assertEquals(null, result.errors);
    }
}