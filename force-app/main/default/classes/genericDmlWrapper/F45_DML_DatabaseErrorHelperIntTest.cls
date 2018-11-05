@IsTest
public class F45_DML_DatabaseErrorHelperIntTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;
    private static final F45_DML_DatabaseErrorRewrapper HELPER_UNDER_TEST = new F45_DML_DatabaseErrorRewrapper();

    @IsTest public static void testConvertShouldReturnAppropriateList() {
        // Arrange
        Account account = new Account();
        Boolean notAllOrNone = false;
        Database.SaveResult saveResult = Database.insert(account, notAllOrNone);
        Database.Error testError = saveResult.getErrors()[0];

        // Act
        List<F45_DML_DatabaseErrorWrapper> resultWrapperList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultWrapperList = HELPER_UNDER_TEST.convert(new List<Database.Error>{
                    testError
            });
        }
        Test.stopTest();

        // Assert
        System.assertEquals(1, resultWrapperList.size());
        F45_DML_DatabaseErrorWrapper resultWrapper = resultWrapperList[0];
        System.assertEquals(testError.getFields(), resultWrapper.fieldList);
        System.assertEquals(testError.getMessage(), resultWrapper.message);
        System.assertEquals(testError.getStatusCode(), resultWrapper.statusCode);
    }

    @IsTest public static void testConvertShouldReturnAnEmptyListWhenNullInput() {
        // Arrange
        // Nothing to do here

        // Act
        List<F45_DML_DatabaseErrorWrapper> resultWrapperList;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultWrapperList = HELPER_UNDER_TEST.convert(null);
        }
        Test.stopTest();

        // Assert
        System.assert(resultWrapperList.isEmpty());
    }
}