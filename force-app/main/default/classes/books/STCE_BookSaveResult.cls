public class STCE_BookSaveResult {
    @AuraEnabled public Book__c book {get; private set;}
    @AuraEnabled public List<String> errors {get; private set;}

    public STCE_BookSaveResult(Book__c book, F45_DML_SaveResultWrapper saveResult) {
        this.book = book;

        if (!saveResult.isSuccess()) {
            this.errors = new List<String>();
            for (F45_DML_DatabaseErrorWrapper error : saveResult.getErrorList()) {
                this.errors.add(error.message);
            }
        }
    }
}