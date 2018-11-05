public class F45_DML_DatabaseErrorWrapper {
    @TestVisible public List<String> fieldList { get; private set; }
    @TestVisible public String message { get; private set; }
    @TestVisible public StatusCode statusCode { get; private set; }

    public F45_DML_DatabaseErrorWrapper(Database.Error error) {
        this.fieldList = error.getFields();
        this.message = error.getMessage();
        this.statusCode = error.getStatusCode();
    }

    @TestVisible private F45_DML_DatabaseErrorWrapper() {
    }
}