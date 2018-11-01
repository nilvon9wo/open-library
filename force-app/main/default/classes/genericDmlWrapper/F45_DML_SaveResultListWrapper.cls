public class F45_DML_SaveResultListWrapper implements F45_DML_ResultListWrapperIntf {
    @TestVisible private List<Database.SaveResult> saveResultList;
    @TestVisible private List<F45_DML_SaveResultWrapper> resultWrapperList;

    public F45_DML_SaveResultListWrapper(List<Database.SaveResult> saveResultList) {
        this.saveResultList = saveResultList;
    }

    public List<F45_DML_SaveResultWrapper> getResultWrapperList() {
        if (this.resultWrapperList == null) {
            this.resultWrapperList = new List<F45_DML_SaveResultWrapper>();
            for (Database.SaveResult saveResult : saveResultList) {
                resultWrapperList.add(new F45_DML_SaveResultWrapper(saveResult));
            }
        }
        return this.resultWrapperList;
    }
}