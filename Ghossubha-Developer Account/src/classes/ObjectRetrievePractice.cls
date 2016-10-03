public with sharing class ObjectRetrievePractice {

    //Method to fetch all objects present in the org
    public List<SelectOption> getAllStdObjNames(){
        //Get all Object names
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None','--None--'));
        for(Schema.SObjectType f : gd){
            options.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getName()));
        }
        return options;
    }
    
    public List<SelectOption> getAllCustomObjNames() {
        //Get all Custom Object names
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None','--None--'));
        for(Schema.SObjectType f : gd){
        if(f.getDescribe().isCustom())
            options.add(new SelectOption(f.getDescribe().getLabel(),f.getDescribe().getLabel()));
        }
        return options;
    }
    
    public String objectName { get; set; }
    public String parentObjectName {get; set;} 
    public list<SelectOption> lsps{get;set;}  
    public String fields { get; set; }
    
    //Method to fetch all objects present in the org
    
    public List<SelectOption> getAllObjNames() {
    //Get all Object names
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None','--None--'));
        for(Schema.SObjectType f : gd){
        options.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getName()));
        }
        return options;
    }
    
    //Method to fetch fields dynamically from the selected objects  
    public void fetchFields() {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        lsps = new List<SelectOption>();
        if(objectName!=null || objectName!=''){
            Map<string,Schema.SObjectField> mpConField=schemaMap.get(objectName).getDescribe().fields.getMap();
            for(String token : mpConField.keyset()){
             lsps.add(new SelectOption(mpConField.get(token).getDescribe().getLabel(),mpConField.get(token).getDescribe().getLabel()));
            }
        }        
    }
    
    // Fetch all child relationship name
    public List<SelectOption> getfetchChildRelationShip() {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeSObjectResult describeResult = Account.SObjectType.getDescribe();
        List<Schema.ChildRelationship> lstchildrelationships = describeResult.getChildRelationships();
        for(Schema.ChildRelationship relname:lstchildrelationships){
             options.add(new SelectOption(relname.getChildSObject().getDescribe().getLabel(),relname.getChildSObject().getDescribe().getLabel()));
        }
        return options;
    }
}