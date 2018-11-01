@IsTest
public class F45_DML_SaveResultListWrapperIntTest {
	private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

	@IsTest public static void testGetResultWrapperListShouldReturnListWithExpectedProperties() {
		// Arrange
		Account testAccount = (Account) (new XFTY_DummySObjectSupplier(Account.SObjectType))
				.setInsertMode(XFTY_InsertModeEnum.LATER)
				.supply();
		Boolean notAllOrNone = false;
		Database.SaveResult testSaveResult = Database.insert(testAccount, notAllOrNone);
		List<Database.SaveResult> testSaveResultList = new List<Database.SaveResult>{testSaveResult}; 
		F45_DML_SaveResultListWrapper wrapperUnderTest = new F45_DML_SaveResultListWrapper(testSaveResultList);				
		
		// Act
		List<F45_DML_SaveResultWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = wrapperUnderTest.getResultWrapperList();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_SaveResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testSaveResult.id, resultWrapper.getId());
		System.assertEquals(testSaveResult.isSuccess(), resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}
}