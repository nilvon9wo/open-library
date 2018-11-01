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

    public List<Database.SaveResult> doInsert(List<SObject> sObjectList) {
        return Database.insert(sObjectList);
    }
}