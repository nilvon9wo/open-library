public class DAO_GenericDml {
    private DAO_GenericDml() {
    }

    private static DAO_GenericDml INSTANCE;

    public static DAO_GenericDml getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new DAO_GenericDml();
        }
        return INSTANCE;
    }

    public static final Boolean ALL_OR_NONE = true;
    public static final Boolean NOT_ALL_OR_NONE = false;

    public List<Database.SaveResult> doInsert(List<SObject> sObjectList, Boolean isAllOrNone) {
        return Database.insert(sObjectList, isAllOrNone);
    }
}