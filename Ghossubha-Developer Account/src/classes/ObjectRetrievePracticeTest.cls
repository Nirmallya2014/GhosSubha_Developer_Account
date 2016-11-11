@isTest
public class ObjectRetrievePracticeTest {

    static testmethod void testObjects() {
        ObjectRetrievePractice objectRe = new ObjectRetrievePractice();
        objectRe.objectName = 'Order';
        objectRe.parentObjectName = 'Order';
        objectRe.selectedField = 'Contract ID';
        objectRe.fetchFields();
        objectRe.fieldDetailsInfo();
        objectRe.getfetchChildRelationShip();
        objectRe.getAllCustomObjNames();
        objectRe.getAllStdObjNames();
        objectRe.getAllObjNames();
    }
}