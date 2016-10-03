trigger UpdateAccountPhone on Contact (before insert, before update) {
    List<Account> updatedAccount = new List<Account>();
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate) {
            List<Account> accList = [Select Id, Phone from Account where Id =: Trigger.new[0].AccountId];
            //Above Query is a Example,you can replace hardcoding zero's for bulkification
            For(Account acnt : accList) {
                acnt.Phone = '9830098300';
                updatedAccount.add(acnt);
            }
        }
        Database.update(updatedAccount);
    }
}