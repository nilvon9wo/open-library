@IsTest
public class F45_DML_DeleteResultListWrapperIntTest {
	private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

	@IsTest public static void testGetResultWrapperListShouldReturnListWithExpectedProperties() {
		// Arrange
        Account testAccount = (Account) (new XFTY_DummySObjectSupplier(Account.SObjectType))
                .setInsertMode(XFTY_InsertModeEnum.NOW)
                .supply();
		Boolean notAllOrNone = false;
		Database.DeleteResult testDeleteResult = Database.delete(testAccount, notAllOrNone);
		List<Database.DeleteResult> testDeleteResultList = new List<Database.DeleteResult>{testDeleteResult}; 
		F45_DML_DeleteResultListWrapper wrapperUnderTest = new F45_DML_DeleteResultListWrapper(testDeleteResultList);				
		
		// Act
		List<F45_DML_DeleteResultWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = wrapperUnderTest.getResultWrapperList();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_DeleteResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testDeleteResult.id, resultWrapper.getId());
		System.assertEquals(testDeleteResult.isSuccess(), resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}
}