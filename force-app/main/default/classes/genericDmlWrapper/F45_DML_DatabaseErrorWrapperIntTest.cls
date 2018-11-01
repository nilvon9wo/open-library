@IsTest
public class F45_DML_DatabaseErrorWrapperIntTest {
	private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

	@IsTest public static void testWrapperShouldContainExpectedPropertiesAfterConstruction() {
		// Arrange
		Account account = new Account();
		Boolean notAllOrNone = false;
		Database.SaveResult saveResult = Database.insert(account, notAllOrNone);
		Database.Error testError = saveResult.getErrors()[0]; 
		
		// Act
		F45_DML_DatabaseErrorWrapper resultWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapper = new F45_DML_DatabaseErrorWrapper(testError);
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(testError.getFields(), resultWrapper.fieldList);
		System.assertEquals(testError.getMessage(), resultWrapper.message);
		System.assertEquals(testError.getStatusCode(), resultWrapper.statusCode);
	}
	
	@IsTest public static void testWrapperConstructionShouldBePossibleWithoutASeedError() {
		// Arrange
		// Nothing to do here
		
		// Act
		F45_DML_DatabaseErrorWrapper resultWrapper;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapper = new F45_DML_DatabaseErrorWrapper();
		}
		Test.stopTest();
		
		// Assert
		System.assertNotEquals(null, resultWrapper);
	}	
}