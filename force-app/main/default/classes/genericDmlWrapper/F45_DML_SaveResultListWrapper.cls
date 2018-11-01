public class F45_DML_SaveResultListWrapper implements F45_DML_ResultListWrapperIntf {
    @TestVisible private List<F45_DML_SaveResultWrapper> resultWrapperList;
    
    public F45_DML_SaveResultListWrapper(List<Database.SaveResult> saveResultList) {
    	this.resultWrapperList = new List<F45_DML_SaveResultWrapper>();
    	for (Database.SaveResult saveResult : saveResultList) {
    		resultWrapperList.add(new F45_DML_SaveResultWrapper(saveResult));
    	} 
    }

    @TestVisible
    private F45_DML_SaveResultListWrapper() {
    }
    
    public List<F45_DML_SaveResultWrapper> getResultWrapperList() {
    	return this.resultWrapperList;
    }
}