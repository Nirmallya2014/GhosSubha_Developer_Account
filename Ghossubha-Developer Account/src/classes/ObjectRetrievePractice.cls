public with sharing class ObjectRetrievePractice {

    public String objectName { get; set; }
    public String parentObjectName {get; set;} 
    public list<SelectOption> lsps{get;set;}  
    public String fields { get; set; }
    public List<SelectOption> childRelationShip{get;set;}
    public List<SelectOption> requiredFieldList{get;set;}
    public String selectedField{get;set;}
    public Map<String, String> fieldDetails {get; set;}
    
    //Method to fetch all objects present in the org
    public List<SelectOption> getAllStdObjNames() {
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
    public void getfetchChildRelationShip() {
        childRelationShip = new List<SelectOption>();
        requiredFieldList = new List<SelectOption>();
        Schema.DescribeSObjectResult objectDef =  Schema.getGlobalDescribe().get(objectName).getDescribe();
        // Get Child Relationship
        List<Schema.ChildRelationship> lstchildrelationships = objectDef.getChildRelationships();
        for(Schema.ChildRelationship relname:lstchildrelationships){
             childRelationShip.add(new SelectOption(relname.getChildSObject().getDescribe().getLabel(),relname.getChildSObject().getDescribe().getLabel()));
        }
        
        // Get Required Fields
        requiredFieldList = new List<SelectOption>();
        Map<String, Schema.SObjectField> fm = objectDef.fields.getMap();
        for(String token : fm.keyset()){
            Schema.DescribeFieldResult describeResult = fm.get(token).getDescribe();
            if(describeResult.isCreateable() && !describeResult.isNillable() && !describeResult.isDefaultedOnCreate()){
                requiredFieldList.add(new SelectOption(describeResult.getLabel(),describeResult.getLabel()));
            }
        }
    }
    
    // Get Field Details
    public void fieldDetailsInfo() {
        try {
            fieldDetails = new Map<String, String>();
            Schema.DescribeSObjectResult objectDef =  Schema.getGlobalDescribe().get(objectName).getDescribe();
            Map<String, Schema.SObjectField> fm = objectDef.fields.getMap();
            system.debug(LoggingLevel.Info, fm);
            for(String token : fm.keyset()){
                Schema.DescribeFieldResult describeResult = fm.get(token).getDescribe();
                system.debug(LoggingLevel.Info, 'DescResult---'+describeResult);
                system.debug(LoggingLevel.Info, 'SelectedField---'+selectedField);
                if(selectedField.equalsIgnoreCase(describeResult.getLabel())){
                system.debug(LoggingLevel.Info, 'Inside If Selected---'+selectedField);
                    fieldDetails.put('ApiName', describeResult.getName());
                    fieldDetails.put('FieldLength', String.valueOf(describeResult.getLength()));
                    fieldDetails.put('FieldType', String.valueOf(describeResult.getType()));
                    if(describeResult.getRelationshipName() != null) {
                        fieldDetails.put('FieldRelationship', describeResult.getRelationshipName());
                    }else {
                        fieldDetails.put('FieldRelationship', '');
                    }
                }
            }
        }catch(Exception ex) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
        }
    }
}