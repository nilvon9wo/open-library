public virtual class F45_DML_GenericDml {
    public static Boolean IS_ALL_OR_NONE = true;
    public static Boolean NOT_ALL_OR_NONE = false;

    @TestVisible
    protected F45_DML_GenericDml() {
    }

    private static F45_DML_GenericDml INSTANCE;

    public static F45_DML_GenericDml getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new F45_DML_GenericDml();
        }
        return INSTANCE;
    }

    public virtual F45_DML_SaveResultListWrapper doInsert(List<SObject> objectList, Boolean isAllOrNone) {
        return new F45_DML_SaveResultListWrapper(Database.insert(objectList, isAllOrNone));
    }

    public virtual F45_DML_SaveResultListWrapper doInsert(List<SObject> objectList) {
        return this.doInsert(objectList, IS_ALL_OR_NONE);
    }

    public virtual F45_DML_SaveResultListWrapper doUpdate(List<SObject> objectList, Boolean isAllOrNone) {
        return new F45_DML_SaveResultListWrapper(Database.update(objectList, isAllOrNone));
    }

    public virtual F45_DML_SaveResultListWrapper doUpdate(List<SObject> objectList) {
        return this.doUpdate(objectList, IS_ALL_OR_NONE);
    }

    public virtual F45_DML_UpsertResultListWrapper doUpsert(List<SObject> homogeneousSObjectList, Boolean isAllOrNone) {
        if (homogeneousSObjectList == null || homogeneousSObjectList.isEmpty()) {
            return null;
        }

        // @see: https://salesforce.stackexchange.com/questions/215514/how-can-i-upsert-a-homogeneous-listsobject-in-a-good-way/215518#215518
        String listType = 'List<' + homogeneousSObjectList[0].getSObjectType() + '>';
        List<SObject> concreteSObjectList = (List<SObject>) Type.forName(listType).newInstance();
        concreteSObjectList.addAll(homogeneousSObjectList);

        return new F45_DML_UpsertResultListWrapper(Database.upsert(homogeneousSObjectList, isAllOrNone));
    }

    public virtual F45_DML_UpsertResultListWrapper doUpsert(List<SObject> homogeneousSObjectList) {
        return this.doUpsert(homogeneousSObjectList, IS_ALL_OR_NONE);
    }

    public virtual F45_DML_DeleteResultListWrapper doDelete(List<SObject> objectList, Boolean isAllOrNone) {
        return new F45_DML_DeleteResultListWrapper(Database.delete(objectList, isAllOrNone));
    }

    public virtual F45_DML_DeleteResultListWrapper doDelete(List<SObject> objectList) {
        return this.doDelete(objectList, IS_ALL_OR_NONE);
    }

    public virtual F45_DML_UndeleteResultListWrapper doUndelete(List<SObject> objectList, Boolean isAllOrNone) {
        return new F45_DML_UndeleteResultListWrapper(Database.undelete(objectList, isAllOrNone));
    }

    public virtual F45_DML_UndeleteResultListWrapper doUndelete(List<SObject> objectList) {
        return this.doUndelete(objectList, IS_ALL_OR_NONE);
    }
}