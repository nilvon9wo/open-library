public class F45_DML_DeleteResultListWrapper implements F45_DML_ResultListWrapperIntf {
    @TestVisible private List<Database.DeleteResult> deleteResultList;
    @TestVisible private List<F45_DML_DeleteResultWrapper> resultWrapperList;

    public F45_DML_DeleteResultListWrapper(List<Database.DeleteResult> deleteResultList) {
        this.deleteResultList = deleteResultList;
    }

    public List<F45_DML_DeleteResultWrapper> getResultWrapperList() {
        if (this.resultWrapperList == null) {
            this.resultWrapperList = new List<F45_DML_DeleteResultWrapper>();
            for (Database.DeleteResult deleteResult : deleteResultList) {
                resultWrapperList.add(new F45_DML_DeleteResultWrapper(deleteResult));
            }
        }
        return this.resultWrapperList;
    }
}