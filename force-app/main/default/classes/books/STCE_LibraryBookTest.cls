@IsTest
public class STCE_LibraryBookTest {
    private static final User TEST_RUNNER = XFTY_DummyUserFactoryOutlet.TEST_ADMIN_USER;

    @IsTest public static void testToSObjectShouldCreateSObjectWhenAtLeastOneAuthorIsListed() {
        // Arrange
        STCE_Library.Book testBook = new STCE_Library.Book();
        testBook.title = 'Sample title';

        STCE_Library.Subject_places testAuthor = new STCE_Library.Subject_places();
        testAuthor.name = 'John Doe';
        testBook.authors = new List<STCE_Library.Subject_places>{testAuthor};

        // Act
        Book__c resultBook;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultBook = testBook.toSObject();
        }
        Test.stopTest();

        // Assert
        System.assertEquals(testBook.title, resultBook.Name);
        System.assertEquals(testAuthor.name, resultBook.Author__c);
    }

    @IsTest public static void testToSObjectShouldCreateSObjectWhenNoAuthorIsListed() {
        // Arrange
        STCE_Library.Book testBook = new STCE_Library.Book();
        testBook.title = 'Sample title';
        testBook.authors = new List<STCE_Library.Subject_places>();

        // Act
        Book__c resultBook;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultBook = testBook.toSObject();
        }
        Test.stopTest();

        // Assert
        System.assertEquals(testBook.title, resultBook.Name);
        System.assertEquals(null, resultBook.Author__c);
    }

    @IsTest public static void testToSObjectShouldCreateSObjectWhenNoAuthorList()  {
        // Arrange
        STCE_Library.Book testBook = new STCE_Library.Book();
        testBook.title = 'Sample title';

        // Act
        Book__c resultBook;
        Test.startTest();
        System.runAs(TEST_RUNNER) {
            resultBook = testBook.toSObject();
        }
        Test.stopTest();

        // Assert
        System.assertEquals(testBook.title, resultBook.Name);
        System.assertEquals(null, resultBook.Author__c);
    }

}