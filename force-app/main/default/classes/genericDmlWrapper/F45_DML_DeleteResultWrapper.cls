public class F45_DML_DeleteResultWrapper implements F45_DML_ResultWrapperIntf {
	private Database.DeleteResult result;
	@TestVisible private Id id;
	@TestVisible private Boolean wasSuccess;

    public F45_DML_DeleteResultWrapper(Database.DeleteResult result) {
        this.result = result;
    	this.id = result.id;
    	this.wasSuccess = result.isSuccess();
    }
    
    @TestVisible
    private F45_DML_DeleteResultWrapper() {
    } 
    
    public Id getId() {
    	return this.id;
	}
	    
    public Boolean isSuccess() {
    	return this.wasSuccess;
	}

	@TestVisible public List<F45_DML_DatabaseErrorWrapper> errorList {
		get {
			if (this.errorList == null) {
				this.errorList = (new F45_DML_DatabaseErrorRewrapper()).convert(result.errors);
			}
			return this.errorList;
		}
		private set;
	}

	public List<F45_DML_DatabaseErrorWrapper> getErrorList() {
		return this.errorList;
	}
}