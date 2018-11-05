@IsTest
public class F45_DML_UndeleteResultListWrapperIntTest {
	private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

	@IsTest public static void testGetResultWrapperListShouldReturnListWithExpectedProperties() {
		// Arrange
		Account testAccount = (Account) (new XFTY_DummySObjectSupplier(Account.SObjectType))
				.setInsertMode(XFTY_InsertModeEnum.NOW)
				.supply();
		Id testAccountId = testAccount.Id;
		delete testAccount;
		Boolean notAllOrNone = false;
		Database.UndeleteResult testUndeleteResult = Database.undelete(testAccountId, notAllOrNone); 
		List<Database.UndeleteResult> testUndeleteResultList = new List<Database.UndeleteResult>{testUndeleteResult}; 
		F45_DML_UndeleteResultListWrapper wrapperUnderTest = new F45_DML_UndeleteResultListWrapper(testUndeleteResultList);				
		
		// Act
		List<F45_DML_UndeleteResultWrapper> resultWrapperList;
		Test.startTest();
		System.runAs(TEST_RUNNER) {
			resultWrapperList = wrapperUnderTest.getResultWrapperList();
		}
		Test.stopTest();
		
		// Assert
		System.assertEquals(1, resultWrapperList.size());
		
		F45_DML_UndeleteResultWrapper resultWrapper = resultWrapperList[0];
		System.assertEquals(testUndeleteResult.id, resultWrapper.getId());
		System.assertEquals(testUndeleteResult.isSuccess(), resultWrapper.isSuccess());
		System.assert(resultWrapper.getErrorList().isEmpty()); 
	}
}