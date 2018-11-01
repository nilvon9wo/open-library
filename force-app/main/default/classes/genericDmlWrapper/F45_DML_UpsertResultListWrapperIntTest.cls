@IsTest
public class F45_DML_UpsertResultListWrapperIntTest {
	private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

	@IsTest public static void testGetResultWrapperListShouldReturnListWithExpectedProperties() {
		// Arrange
		Account testAccount = (Account) (new XFTY_DummySObjectSupplier(Account.SObjectType))
				.setInsertMode(XFTY_InsertModeEnum.LATER)
				.supply();
		Boolean notAllOrNone = false;
		Database.UpsertResult testUpsertResult = Database.upsert(testAccount, notAllOrNone);
		List<Database.UpsertResult> testUpsertResultList = new List<Database.UpsertResult>{testUpsertResult}; 
		F45_DML_UpsertResultListWrapper wrapperUnderTest = new F45_DML_UpsertResultListWrapper(testUpsertResultList);				
		
		// Act
		List<F45_DML_UpsertResultWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = wrapperUnderTest.getResultWrapperList();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_UpsertResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testUpsertResult.id, resultWrapper.getId());
		System.assertEquals(testUpsertResult.isCreated(), resultWrapper.wasCreated);
		System.assertEquals(testUpsertResult.isSuccess(), resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty());
	}
}