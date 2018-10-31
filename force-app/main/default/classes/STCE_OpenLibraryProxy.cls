public class STCE_OpenLibraryProxy {
    private static final String ENDPOINT = 'https://openlibrary.org/api/books?bibkeys=OLID:OL22895148M,OLID:OL6990157M,OLID:OL7101974M,OLID:OL6732939M,OLID:OL7193048M,OLID:OL24347578M,OLID:OL24364628M,OLID:OL24180216M,OLID:OL24948637M,OLID:OL1631378M,OLID:OL979600M,OLID:OL33674M,OLID:OL7950349M,OLID:OL349749M,OLID:OL30460M,OLID:OL24347578M&jscmd=data&format=json';

    private STCE_OpenLibraryProxy() {
    }

    private static STCE_OpenLibraryProxy INSTANCE;

    public static STCE_OpenLibraryProxy getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new STCE_OpenLibraryProxy();
        }
        return INSTANCE;
    }

    public List<STCE_Library.Book> getBooks() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ENDPOINT);
        req.setMethod('GET');

        String jsonResp = new Http().send(req).getBody();
        Map<String, STCE_Library.Book> books
                = (Map<String, STCE_Library.Book>)JSON.deserializeStrict(jsonResp, Map<String, STCE_Library.Book>.class);

        return books.values();
    }
}