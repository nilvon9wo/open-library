public class F45_DML_SaveResultWrapper implements F45_DML_ResultWrapperIntf {
	@TestVisible private Id id;
	@TestVisible private Boolean wasSuccess;
	@TestVisible private List<F45_DML_DatabaseErrorWrapper> errorList; 
	 
    public F45_DML_SaveResultWrapper(Database.SaveResult result) {
    	this.id = result.id;
    	this.wasSuccess = result.isSuccess();
    	this.errorList = (new F45_DML_DatabaseErrorHelper()).convert(result.errors);
    } 
    
    @TestVisible
    private F45_DML_SaveResultWrapper() {
    } 
    
    public Id getId() {
    	return this.id;
	}
	    
    public Boolean isSuccess() {
    	return this.wasSuccess;
	}
	
	public List<F45_DML_DatabaseErrorWrapper> getErrorList() {
		return this.errorList;
	}
}