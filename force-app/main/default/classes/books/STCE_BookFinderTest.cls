@IsTest
public class STCE_BookFinderTest {
    private static final STCE_BookFinder FINDER_UNDER_TEST = STCE_BookFinder.getInstance();

    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;
    private static final Book__c TEST_BOOK = (Book__c) (new XFTY_DummySObjectSupplier(Book__c.SObjectType))
            .setInsertMode(XFTY_InsertModeEnum.NEVER)
            .supply();

    private static final String TEST_TITLE = 'Tail of Two Cities';
    private static final String TEST_TITLE_LOWERCASE = TEST_TITLE.toLowerCase();
    private static final String TEST_AUTHOR = 'Charles Dickens';
    private static final String TEST_OLID = 'OL24364628M';

    private static final Boolean IS_MATCHING = true;
    private static final Boolean NOT_MATCHING = false;

    @IsTest public static void testExtractMatchesShouldReturnListOfMatchingBooks() {/* TODO */}
    @IsTest public static void testExtractMatchesShouldReturnEmptyListIfNoMatchingBooks() {/* TODO */}

    @IsTest public static void testExtractMatchesByIdShouldReturnBookFromMapKeyWhenPossible() {/* TODO */}
    @IsTest public static void testExtractMatchesByIdShouldReturnBookFromMapValuesWhenNoKeyMatches() {/* TODO */}

    @IsTest public static void testExtractMatchesByIdShouldReturnListOfMatchingBooks() {/* TODO */}
    @IsTest public static void testExtractMatchesByIdShouldReturnEmptyListIfNoMatchingBooks() {/* TODO */}

    @IsTest public static void testHasMatchingAnythingShouldReturnTrueIfTitleMatches() {/* TODO */}
    @IsTest public static void testHasMatchingAnythingShouldReturnTrueIfAuthorMatches() {/* TODO */}
    @IsTest public static void testHasMatchingAnythingShouldReturnTrueIfIdMatches() {/* TODO */}
    @IsTest public static void testHasMatchingAnythingShouldReturnFalseIfNoMatches() {/* TODO */}

    @IsTest public static void testHasMatchingTitleShouldReturnTrueIfTitleMatches() {/* TODO */}
    @IsTest public static void testHasMatchingTitleShouldReturnFalseIfTitleDoesntMatch() {/* TODO */}

    @IsTest public static void testHasMatchingAuthorShouldReturnTrueIfAuthorMatchesByStatement() {/* TODO */}
    @IsTest public static void testHasMatchingAuthorShouldReturnTrueIfAuthorInBookAuthorList() {/* TODO */}
    @IsTest public static void testHasMatchingAuthorShouldReturnFalseIfAuthorDoesntMatch() {/* TODO */}

    @IsTest public static void testHasMatchingAuthorShouldReturnTrueIfAuthorInAuthorList() {/* TODO */}
    @IsTest public static void testHasMatchingAuthorShouldReturnFalseIfAuthorListIsNull() {/* TODO */}
    @IsTest public static void testHasMatchingAuthorShouldReturnFalseIfAuthorNotInAuthorList() {/* TODO */}

    @IsTest public static void testHasMatchingIdShouldReturnTrueIfBookIdentifiersOpenLibraryListContainsId() {/* TODO */}
    @IsTest public static void testHasMatchingIdShouldReturnFalseIfBookHasNoIdentifiers() {/* TODO */}

    @IsTest public static void testHasMatchingIdShouldReturnTrueIfOpenLibraryListContainsId() {/* TODO */}
    @IsTest public static void testHasMatchingIdShouldReturnFalseIfOpenLibraryListDoesNotContainId() {/* TODO */}
    @IsTest public static void testHasMatchingIdShouldReturnFalseIfOpenLibraryListIsNull() {/* TODO */}

    // nonBlankCaseInsensitiveContains Tests --------------------------------------------------------------------------

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnFalseIfTargetIsNull() {
        testNonBlankCaseInsensitiveContains(null, TEST_TITLE_LOWERCASE, NOT_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnFalseIfTargetIsEmpty() {
        testNonBlankCaseInsensitiveContains('', TEST_TITLE_LOWERCASE, NOT_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnTrueIfTargetIsLowerCaseAndTermIsMatchingLowerCase() {
        testNonBlankCaseInsensitiveContains(TEST_TITLE.toLowerCase(), TEST_TITLE_LOWERCASE, IS_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnTrueIfTargetIsUpperCaseAndTermIsMatchingLowerCase() {
        testNonBlankCaseInsensitiveContains(TEST_TITLE.toUpperCase(), TEST_TITLE_LOWERCASE, IS_MATCHING);
    }

    @IsTest public static void testNonBlankCaseInsensitiveContainsShouldReturnFalseIfTargetDoesNotMatch() {
        testNonBlankCaseInsensitiveContains(TEST_AUTHOR, TEST_TITLE_LOWERCASE, NOT_MATCHING);
    }

    private static void testNonBlankCaseInsensitiveContains(String testTarget, String testLowerCaseSearchTerm, Boolean expectation)   {
        // Arrange
        // Nothing to do here.

        // Act
        Boolean result;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            result = FINDER_UNDER_TEST.nonBlankCaseInsensitiveContains(testTarget, testLowerCaseSearchTerm);
        }
        Test.stopTest();

        // Assert
        System.assertEquals(expectation, result);
    }

}