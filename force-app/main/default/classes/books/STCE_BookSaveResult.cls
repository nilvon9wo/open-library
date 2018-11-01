public class STCE_BookSaveResult {
    @AuraEnabled public Book__c book;
    @AuraEnabled public List<String> errors;

    public STCE_BookSaveResult(Book__c book, Database.SaveResult saveResult) {
        this.book = book;

        if (!saveResult.isSuccess()) {
            this.errors = new List<String>();
            for (Database.Error error : saveResult.errors) {
                this.errors.add(error.getMessage());
            }
        }
    }
}