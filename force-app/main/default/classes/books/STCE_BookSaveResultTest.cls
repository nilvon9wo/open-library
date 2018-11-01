@IsTest
public class STCE_BookSaveResultTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

    @IsTest public static void testConstructorShouldWrapBookAndNoErrorsWhenSaveSucceeds() {
        // Arrange
        Book__c testBook = (Book__c) (new XFTY_DummySObjectSupplier(Book__c.SObjectType))
                .setInsertMode(XFTY_InsertModeEnum.MOCK)
                .supply();

        F45_DML_SaveResultWrapper testSaveResult = new F45_DML_SaveResultWrapper();
        testSaveResult.wasSuccess = true;

        // Act
        STCE_BookSaveResult bookSaveResult;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            bookSaveResult = new STCE_BookSaveResult(testBook, testSaveResult);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(testBook, bookSaveResult.book);
        System.assertEquals(null, bookSaveResult.errors);
    }

    @IsTest public static void testConstructorShouldWrapBookAndErrorsWhenSaveFails()  {
        // Arrange
        Book__c testBook = (Book__c) (new XFTY_DummySObjectSupplier(Book__c.SObjectType))
                .setInsertMode(XFTY_InsertModeEnum.NEVER)
                .supply();

        F45_DML_SaveResultWrapper testSaveResult = new F45_DML_SaveResultWrapper();
        testSaveResult.wasSuccess = false;
        F45_DML_DatabaseErrorWrapper testError = new F45_DML_DatabaseErrorWrapper();
        testError.message = 'test message';
        testSaveResult.errorList = new List<F45_DML_DatabaseErrorWrapper>{testError};


        // Act
        STCE_BookSaveResult bookSaveResult;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            bookSaveResult = new STCE_BookSaveResult(testBook, testSaveResult);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(testBook, bookSaveResult.book);
        System.assert(bookSaveResult.errors.contains(testError.message));
    }
}