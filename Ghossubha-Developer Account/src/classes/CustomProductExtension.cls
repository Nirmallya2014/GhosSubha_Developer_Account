public with sharing class CustomProductExtension {
    Public String Name {get; set;}
    Public String Family {get; set;}
    Public String Description {get; set;}
    Public Decimal ProductCost {get; Set;}
    public List<SelectOption> ProductTypeList{get;set;}
    Public String Type {get; set;}
    Public Boolean isActive {get; set;}
    Public String prodAddedBy {get; set;}
    
    /**************** Order Param *****************/
    public String CustomerName{get; set;}
    public String CustomerPhone{get; set;}
    public String CustomerAddress{get; set;}
    public String prodss{get; set;}
    public List<SelectOption> orderStatusList{get;set;}
    public String orderStatus{get; Set;}
    public String nearestLocation{get;set;}
    Public String impNotes {get; set;}
    
    public boolean showAddProductButton {get; set;}
    public boolean showAddOrderButton {get; set;}
    public List<SelectOption> ownerList{get;set;}
    public String deleteId{get; set;}
    public String deleteOrderId{get; set;}
    
    /**************** Update Order and Product *****************/
    Public Order ord{get;set;}
    
    public static List<SelectOption> getPicklistValues(String ObjectApi_name,String Field_name){ 
        List<SelectOption> optionList = new List<SelectOption>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectApi_name);//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> pick_list_values = field_map.get(Field_name).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry f : pick_list_values) { //for all values in the picklist list
            optionList.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        return optionList;
    }
    
    Public List<Product2> getProduct2List() {
        List<Product2> prodList = [Select Id, Name, Family, Description, ProductCost__c, Type__c,ProductCode__c, IsActive From Product2 Where ProductCode__c Like 'HAN%' ORDER BY CREATEDDATE DESC];
        return prodList;
    }
    Public List<Order> getOrderList() {
        List<Order> ordList = [Select Id, CustomerName__c, imp_notes__c, CustomerAddress__c, nearestLocation__c, Status, PhoneNo__c, OrderedProducts__c, OrderNumber, EffectiveDate From Order ORDER BY CREATEDDATE DESC];
        if(ordList.size() > 0)
            return ordList;
        else 
            return null;
    }
    
    public List<Product2> getLookupProduct() {
        return [Select Name, Family, Description, ProductCost__c, Type__c,ProductCode__c, IsActive From Product2 Where ProductCode__c Like 'HAN%'];
    }
    public CustomProductExtension() {
        showAddProductButton = true;
        showAddOrderButton = true;
        orderStatusList = getPicklistValues('Order', 'Status'); 
        ProductTypeList = getPicklistValues('Product2', 'Type__c');
        ownerList = getPicklistValues('Product2', 'Product_Added_By__c');
        if(ApexPages.currentPage().getParameters().containsKey('updateOrder') && ApexPages.currentPage().getParameters().get('updateOrder').equalsIgnoreCase('true')) {
            Id UrlId = ApexPages.currentPage().getParameters().get('orderId');
            ord = [Select Id, CustomerName__c, CustomerAddress__c, nearestLocation__c, Status, PhoneNo__c, imp_notes__c, OrderedProducts__c, OrderNumber, EffectiveDate From Order Where Id =:UrlId];
        }else if(ApexPages.currentPage().getParameters().containsKey('updateProduct') && ApexPages.currentPage().getParameters().get('updateProduct').equalsIgnoreCase('true')){
            
        }
    }
    public List<String> getOrderStatusListInfo() {
        return null;
    }
    public PageReference SaveAndRedirect() {
        //try {
        Product2 prods = new Product2();
        prods.Name = Name;
        prods.Family = Family;
        prods.Description = Description;
        prods.Type__c = type;
        prods.IsActive = IsActive;
        prods.ProductCost__c = ProductCost;
        insert prods;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info, 'Product Added Successfully'));
        //}Catch(Exception ex) {
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
        //}
        return null;
    }
    
    Public PageReference SaveOrder() {
        //try {
        Account acc = [Select Id From Account Limit 1];
        Order orderList = new Order();
        orderList.CustomerName__c = CustomerName;
        orderList.CustomerAddress__c = CustomerAddress;
        orderList.PhoneNo__c = CustomerPhone;
        orderList.Status = orderStatus;
        orderList.NearestLocation__c = NearestLocation;
        orderList.OrderedProducts__c = prodss;
        orderList.AccountId =  acc.Id;
        orderList.EffectiveDate = Date.today();
        orderList.Imp_Notes__c = impNotes;
        insert orderList;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info, 'Data Inserted Successfully'));
        //}Catch(Exception ex) {
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
        //}
        return null;
    }
    
    public void deleteProduct() {
        List<Product2> delProd = [Select Id, Name From Product2 Where Id =: deleteId];
        delete delProd;
    }
    public void deleteOrder() {
        List<Order> delOrder = [Select Id, Name From Order Where Id =: deleteOrderId];
        delete delOrder;
    }
    
    @RemoteAction
    public static String EditAndSaveOrder(Map<String, String> orderInfo) {
        try {
            system.debug('Map Details'+orderInfo);
            Order orderL = [Select Id, CustomerName__c, imp_notes__c, CustomerAddress__c, nearestLocation__c, Status, PhoneNo__c, OrderedProducts__c, OrderNumber, EffectiveDate From Order Where Id =: orderInfo.get('corderId')];
            orderL.CustomerName__c = orderInfo.get('cname');
            orderL.CustomerAddress__c = orderInfo.get('caddress');
            orderL.PhoneNo__c = orderInfo.get('cphone');
            orderL.Status = orderInfo.get('corderstatus');
            orderL.NearestLocation__c = orderInfo.get('cplocation'); 
            orderL.Imp_Notes__c = orderInfo.get('cimpnotes');
            update orderL;
            return 'success';
        }Catch(Exception ex) {
            return ex.getMessage();
        }
        
    }
}