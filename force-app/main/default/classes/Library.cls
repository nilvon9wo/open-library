public class Library {

    @AuraEnabled
    public static String getBooks() {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://openlibrary.org/api/books?bibkeys=OLID:OL22895148M,OLID:OL6990157M,OLID:OL7101974M,OLID:OL6732939M,OLID:OL7193048M,OLID:OL24347578M,OLID:OL24364628M,OLID:OL24180216M,OLID:OL24948637M,OLID:OL1631378M,OLID:OL979600M,OLID:OL33674M,OLID:OL7950349M,OLID:OL349749M,OLID:OL30460M,OLID:OL24347578M&jscmd=data&format=json');
        req.setMethod('GET');

        HttpResponse resp = new Http().send(req);

        String jsonResp = resp.getBody();

        Map<String, Book> books = (Map<String, Book>)JSON.deserializeStrict(jsonResp, Map<String, Book>.class);

        return JSON.serialize(books.values());

    }

    public class Table_of_contents {
        public String title;
        public String label;
        public String pagenum;
        public Integer level;
    }

    public class Book {
        public List<Publishers> publishers;
        public String pagination;
        public Identifiers identifiers;
        public Classifications classifications;
        public List<Table_of_contents> table_of_contents;
        public String subtitle;
        public String weight;
        public List<Links> links;
        public String title;
        public String url;
        public String notes;
        public Integer number_of_pages;
        public Cover cover;
        public List<Subject_places> subject_places;
        public List<Subject_places> subjects;
        public List<Subject_places> subject_people;
        public String key;
        public List<Subject_places> authors;
        public String publish_date;
        public String by_statement;
        public List<Publishers> publish_places;
        public List<Subject_places> subject_times;
        public List<Excerpts> excerpts;
        public List<Ebooks> ebooks;
    }

    public class Identifiers {
        public List<String> goodreads;
        public List<String> isbn_10;
        public List<String> isbn_13;
        public List<String> lccn;
        public List<String> librarything;
        public List<String> oclc;
        public List<String> openlibrary;
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
        public String medium;
    }

    public class Links {
        public String url;
        public String title;
    }
    public class Subject_places {
        public String url;
        public String name;
    }

}