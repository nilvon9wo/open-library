@IsTest
public class STCE_OpenLibraryProxyTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;
    private static final STCE_OpenLibraryProxy PROXY_UNDER_TEST = STCE_OpenLibraryProxy.getInstance();

    private static final String SAMPLE_TITLE = 'Great expectations';
    private static final String SAMPLE_OLID = 'OL24364628M';

    private static final String SAMPLE_JSON
            = '{"OLID:' + SAMPLE_OLID
                    + '":{"publishers":[{"name":"S.H. Goetzel"}],"pagination":"368 p. ;","identifiers":{"openlibrary":["OL24364628M"]},'
                    + '"title":"' + SAMPLE_TITLE
                    + '","url":"https://openlibrary.org/books/OL24364628M/Great_expectations","number_of_pages":368,"cover":{"small":"https://covers.openlibrary.org/b/id/6995592-S.jpg","large":"https://covers.openlibrary.org/b/id/6995592-L.jpg","medium":"https://covers.openlibrary.org/b/id/6995592-M.jpg"},"publish_date":"1863","key":"/books/OL24364628M","by_statement":"by Charles Dickens","publish_places":[{"name":"Mobile"}],"ebooks":[{"formats":{"pdf":{"url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick.pdf"},"epub":{"url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick.epub"},"text":{"url":"https://archive.org/download/greatexpectatio00dick/greatexpectatio00dick_djvu.txt"}},"preview_url":"https://archive.org/details/greatexpectatio00dick","read_url":"https://archive.org/stream/greatexpectatio00dick","availability":"full"}]}}';

    @IsTest public static void testGetBooksShouldReturnBooks() {
        // Arrange
        HttpResponse testHttpResponse = new HttpResponse();
        testHttpResponse.setBody(SAMPLE_JSON);
        TEST_GenericHttpCalloutMock mockCallout = new TEST_GenericHttpCalloutMock(testHttpResponse);
        Test.setMock(HttpCalloutMock.class, mockCallout);

        // Act
        Map<String, STCE_Library.Book> resultBooksByPrefixedOlidMap;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultBooksByPrefixedOlidMap = PROXY_UNDER_TEST.getBooks();
        }
        Test.stopTest();

        // Assert
        System.assertEquals(1, resultBooksByPrefixedOlidMap.size());
        String prefixedOlid = 'OLID:' + SAMPLE_OLID;
        System.assert(resultBooksByPrefixedOlidMap.containsKey(prefixedOlid));
        System.assertEquals(SAMPLE_TITLE, resultBooksByPrefixedOlidMap.get(prefixedOlid).title);

        HttpRequest receivedHttpRequest = mockCallout.recievedHttpRequest;
        System.assertEquals(STCE_OpenLibraryProxy.ENDPOINT, receivedHttpRequest.getEndpoint());
        System.assertEquals('GET', receivedHttpRequest.getMethod());
    }
}