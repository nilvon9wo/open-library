@IsTest
public class STCE_OpenLibraryProxyMock extends STCE_OpenLibraryProxy {
    public Boolean wasCalled;
    public Map<String, STCE_Library.Book> returnedBooksByIdMap;
    public override Map<String, STCE_Library.Book> getBooks() {
        this.wasCalled = true;
        return this.returnedBooksByIdMap;
    }
}