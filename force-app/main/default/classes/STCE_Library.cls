public class STCE_Library {

    public class Table_of_contents {
        public String title;
        public String label;
        public String pagenum;
        public Integer level;
    }

    public class Book {
        public List<Publishers> publishers;
        public String pagination;
        @AuraEnabled public Identifiers identifiers;
        public Classifications classifications;
        public List<Table_of_contents> table_of_contents;
        public String subtitle;
        public String weight;
        public List<Links> links;
        @AuraEnabled public String title;
        public String url;
        public String notes;
        public Integer number_of_pages;
        @AuraEnabled public Cover cover;
        public List<Subject_places> subject_places;
        public List<Subject_places> subjects;
        public List<Subject_places> subject_people;
        public String key;
        public List<Subject_places> authors;
        public String publish_date;
        @AuraEnabled public String by_statement;
        public List<Publishers> publish_places;
        public List<Subject_places> subject_times;
        public List<Excerpts> excerpts;
        public List<Ebooks> ebooks;

        public Book__c toSObject() {
            return new Book__c(
                    Name = this.title,
                    Author__c = this.authors[0].name
            );
        }
    }

    public class Identifiers {
        public List<String> goodreads;
        public List<String> isbn_10;
        public List<String> isbn_13;
        public List<String> lccn;
        public List<String> librarything;
        public List<String> oclc;
        @AuraEnabled public List<String> openlibrary;
    }

    public class Ebooks {
        public String borrow_url;
        public Boolean checkedout;
        public Formats formats;
        public String preview_url;
        public String read_url;
        public String availability;
    }

    public class Format {
        public String url;
    }

    public class Publishers {
        public String name;
    }

    public class Classifications {
        public List<String> dewey_decimal_class;
        public List<String> lc_classifications;
    }

    public class Excerpts {
        public String comment;
        public String text;
        public Boolean first_sentence;
    }

    public class Formats {
        public Format pdf;
        public Format epub;
        public Format text;
    }

    public class Cover {
        public String small;
        public String large;
        @AuraEnabled public String medium;
    }

    public class Links {
        public String url;
        public String title;
    }
    public class Subject_places {
        public String url;
        @AuraEnabled public String name;
    }
}