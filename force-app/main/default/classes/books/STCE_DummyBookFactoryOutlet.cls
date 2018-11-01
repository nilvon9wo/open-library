@IsTest
public class STCE_DummyBookFactoryOutlet implements XFTY_DummySObjectFactoryOutletIntf {
    public static final String DEFAULT_NAME_PREFIX = 'Test Book__c Name';

    private static final SObjectField PRIMARY_TARGET_FIELD = Book__c.Id;
    private static final XFTY_DummySObjectMasterTemplate MASTER_TEMPLATE = new XFTY_DummySObjectMasterTemplate(PRIMARY_TARGET_FIELD)
            .put(Book__c.Name, new XFTY_DummyDefaultValueUniqueString(DEFAULT_NAME_PREFIX));

    public SObjectField getPrimaryTargetField() {
        return PRIMARY_TARGET_FIELD;
    }

    public XFTY_DummySObjectMasterTemplate getMasterTemplate() {
        return MASTER_TEMPLATE;
    }

    public XFTY_DummySObjectBundle createBundle(
            List<SObject> templateSObjectList,
            XFTY_InsertModeEnum insertMode,
            XFTY_InsertInclusivityEnum inclusivity
    ) {
        return XFTY_DummySObjectFactory.createBundle(MASTER_TEMPLATE, templateSObjectList, insertMode, inclusivity);
    }
}