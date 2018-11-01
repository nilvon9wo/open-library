public class F45_DML_UndeleteResultListWrapper implements F45_DML_ResultListWrapperIntf {
    @TestVisible private List<Database.UndeleteResult> undeleteResultList;
    @TestVisible private List<F45_DML_UndeleteResultWrapper> resultWrapperList;

    public F45_DML_UndeleteResultListWrapper(List<Database.UndeleteResult> undeleteResultList) {
        this.undeleteResultList = undeleteResultList;
    }

    public List<F45_DML_UndeleteResultWrapper> getResultWrapperList() {
        if (this.resultWrapperList == null) {
            this.resultWrapperList = new List<F45_DML_UndeleteResultWrapper>();
            for (Database.UndeleteResult undeleteResult : undeleteResultList) {
                resultWrapperList.add(new F45_DML_UndeleteResultWrapper(undeleteResult));
            }
        }
        return this.resultWrapperList;
    }
}