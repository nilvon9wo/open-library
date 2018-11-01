public class F45_DML_UpsertResultListWrapper implements F45_DML_ResultListWrapperIntf {
    @TestVisible private List<Database.UpsertResult> upsertResultList;
    @TestVisible private List<F45_DML_UpsertResultWrapper> resultWrapperList;

    public F45_DML_UpsertResultListWrapper(List<Database.UpsertResult> upsertResultList) {
        this.upsertResultList = upsertResultList;
    }

    public List<F45_DML_UpsertResultWrapper> getResultWrapperList() {
        if (this.resultWrapperList == null) {
            this.resultWrapperList = new List<F45_DML_UpsertResultWrapper>();
            for (Database.UpsertResult upsertResult : upsertResultList) {
                resultWrapperList.add(new F45_DML_UpsertResultWrapper(upsertResult));
            }
        }
        return this.resultWrapperList;
    }
}