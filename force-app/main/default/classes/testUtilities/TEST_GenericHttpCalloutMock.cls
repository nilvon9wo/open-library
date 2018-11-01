@IsTest
public class TEST_GenericHttpCalloutMock implements HttpCalloutMock {
    private HttpResponse httpResponse;

    public TEST_GenericHttpCalloutMock(HttpResponse httpResponse){
        this.httpResponse = httpResponse;
    }

    public HttpRequest recievedHttpRequest;
    public HttpResponse respond(HttpRequest httpRequest) {
        this.recievedHttpRequest = httpRequest;
        return this.httpResponse;
    }
}