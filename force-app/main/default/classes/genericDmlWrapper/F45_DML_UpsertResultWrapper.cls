public class F45_DML_UpsertResultWrapper implements F45_DML_ResultWrapperIntf {
	private Database.UpsertResult result;
	@TestVisible private Id id;
	@TestVisible private Boolean wasSuccess;
	@TestVisible private Boolean wasCreated;
	@TestVisible private List<F45_DML_DatabaseErrorWrapper> errorList; 
	
    public F45_DML_UpsertResultWrapper(Database.UpsertResult result) {
		this.result = result;
    	this.id = result.id;
    	this.wasCreated = result.isCreated();
    	this.wasSuccess = result.isSuccess();
    }
    
    @TestVisible
    private F45_DML_UpsertResultWrapper() {
    } 
    
    public Id getId() {
    	return this.id;
	}
	    
    public Boolean isCreated() {
    	return this.wasCreated;
	}
	
    public Boolean isSuccess() {
    	return this.wasSuccess;
	}

	public List<F45_DML_DatabaseErrorWrapper> getErrorList() {
		if (this.errorList == null) {
			this.errorList = (new F45_DML_DatabaseErrorRewrapper()).convert(result.errors);
		}
		return this.errorList;
	}
}