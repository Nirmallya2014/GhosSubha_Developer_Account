/**********************************************************************
 Name:  	Vitality_RegistrationRequestController
 Purpose: 	This Controller class is respoonsible for User registration from portal site                                                          
**********************************************************************/

public class Vitality_RegistrationRequestController{
    public string languageCode {get; set;}
    
    public PageReference handleTranslation() {
        if(ApexPages.currentPage().getParameters().get('langCode') == 'fr') {
            languageCode = 'fr';
            PageReference redirectNextPage = new PageReference('/VitalityRegistration/Vitality_Registration_Request_Form_Fr');
            redirectNextPage.setRedirect(true);
            return redirectNextPage;
        }else if(ApexPages.currentPage().getParameters().get('langCode') == 'en') {
            languageCode = 'en_US';
            PageReference redirectNextPage = new PageReference('/VitalityRegistration/Vitality_Registration_Request_Form');
            redirectNextPage.setRedirect(true);
            return redirectNextPage;
        }
        return null;
    }
    
    @RemoteAction
    public static Map<string, string> checkContactExist(Map<string, string> regInfo) {
        Map<String, String> returnMsg = new Map<String, String>();
        try {
            /*Start of New Changes */
            Date dobDateValue = Date.ValueOf(regInfo.get('dateOfBirth'));
            String newDob = dobDateValue.month() + '/' + dobDateValue.day() + '/' + dobDateValue.year(); 
            String inputEncryption = /*String.valueOf(dobDateValue)*/newDob + userinfo.getOrganizationId();
            Blob b = Crypto.generateDigest('SHA-256', Blob.valueOf(inputEncryption));
            String encryptedDob = EncodingUtil.base64Encode(b);
            /* End of New Changes */
            Membership__c memberRecord = [select membershipid__c, Status__c, member__r.firstname, member__r.lastname, member__r.email, member__r.portalregistrationid__c, member__r.birthdate 
                                          from membership__c where Type__c = 'Vitality' AND member__r.email=: regInfo.get('email') AND 
                                          member__r.lastName =: regInfo.get('lastName') AND member__r.Vitality_DOB__c =: encryptedDob 
                                          AND member__r.portalregistrationid__c =: regInfo.get('policyNumber') limit 1];
            if(memberRecord != null) {
                if(memberRecord.Status__c.equalsIgnoreCase(Vitality_Constants.MEMBERSHIP_TERMINATED_STATUS)) {
                    returnMsg.put('policyRelated', Vitality_Constants.ISTRUEFLAG);
                    returnMsg.put('status', Vitality_Constants.ISERRORFLAG);
                    returnMsg.put('msg', Label.lbl_PolicyTerminated); 
                }else if(memberRecord.Status__c.equalsIgnoreCase('Active')) {
                    returnMsg.put('status', Vitality_Constants.ISSUCCESSFLAG);
                    returnMsg.put('id', String.valueOf(memberRecord.Id));
                    returnMsg.put('email', String.valueOf(memberRecord.member__r.email));
                }else {
                    returnMsg.put('status', Vitality_Constants.ISERRORFLAG);
            		returnMsg.put('msg', Label.lbl_MatchRecord);
                }
            }
        }Catch(Exception ex) {
            returnMsg.put('status', Vitality_Constants.ISERRORFLAG);
            returnMsg.put('msg', Label.lbl_MatchRecord);
        }
        return returnMsg;
    }
    
    public static HTTPResponse invokeISAMCallouts(Map<string, Object> isamRequest) {
        String JSONString = JSON.serialize(isamRequest);
        IntegrationEndpoints__c registrationEndpoint = IntegrationEndpoints__c.getValues('Registration');
        String endpointsUrl = registrationEndpoint.EndpointUrl__c;
        try {
            Http httpCall = new Http();
            HttpRequest request = new HttpRequest();
            if(Test.isRunningTest()) {
                request.setEndpoint(endpointsUrl);   
            }else {
                request.setEndpoint('callout:ISAM'); 
            }
            request.setMethod('POST');
            request.setTimeout(60000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(JSONString);
            HTTPResponse res = httpCall.send(request);
            return res;
        }Catch(Exception ex) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
        }
        return null;
    }
    
    @RemoteAction
    public static Map<String, String> createAccount(Map<String, String> remoteParam) {
        HTTPResponse res = null;
        Map<string, string> returnMsg = new Map<String, String>();
        Id accountId;
        Id accountOwnerId;
        Id accountOwnerRoleId = null;
        try {
            Membership__c memberRecord = [select membershipid__c, member__r.firstname, member__r.lastname, member__r.email, member__r.portalregistrationid__c, member__r.birthdate, member__r.AccountId 
                                          from membership__c where Id =: remoteParam.get('urlIdVal')];
            if(memberRecord != null) {
                accountId = memberRecord.member__r.AccountId;
                Account accInfo = [select OwnerId from account where id =: accountId];
                accountOwnerId = accInfo.OwnerId;
                User usr = [select UserRoleId from User where id =: accountOwnerId];
                if(usr.UserRoleId != null) {
                    accountOwnerRoleId = usr.UserRoleId;
                }
            }
            if(accountOwnerRoleId != null) {
                Map<String, Object> isamRequest = new Map<String, Object>();
                isamRequest.put('requestType', 'Registration');
                if(memberRecord.member__r.FirstName != null) {
                    isamRequest.put('firstName', memberRecord.member__r.FirstName);
                }else {
                    isamRequest.put('firstName', '');
                }
                isamRequest.put('lastName', memberRecord.member__r.LastName);
                isamRequest.put('tvgFedId', memberRecord.membershipid__c);
                isamRequest.put('salesforcefedid', memberRecord.Id);
                isamRequest.put('password', remoteParam.get('passwordVal'));
                isamRequest.put('userid', memberRecord.member__r.Email);
                res = invokeISAMCallouts(isamRequest);
                if(res!= null && res.getStatusCode() != 500) {
                    Map<String, string> mapResponse = (Map<String, string>)JSON.deserialize(res.getBody(), Map<String, string>.class);
                    if (mapResponse.get('success').equalsIgnoreCase('true')) {
                        List<User> usrList = [select id, LastName From User Where Email =: memberRecord.Member__r.Email];
                        if(usrList.isEmpty()) {
                            createUser(memberRecord, remoteParam.get('langCode'));
                            returnMsg.put('status', Vitality_Constants.ISSUCCESSFLAG);
                            returnMsg.put('params', memberRecord.member__r.Email);
                            return returnMsg;
                        }else {
                            returnMsg.put('status', Vitality_Constants.ISSUCCESSFLAG);
                            returnMsg.put('params', memberRecord.member__r.Email);
                            return returnMsg;
                        }
                    }else if(mapResponse.get('success').equalsIgnoreCase('false')){
                        /**************Start Post Production Fix 20 Sep*******************/
                        returnMsg = displayISAMErrorMessage(returnMsg, mapResponse, remoteParam);
                        /**************End Post Production Fix 20 Sep*******************/
                        return returnMsg;
                    }
                }else {
                    returnMsg.put('IsamError', Vitality_Constants.ISTRUEFLAG);
                    returnMsg.put('status', Vitality_Constants.ISERRORFLAG);
                    returnMsg.put('msg', Label.Vitality_ISAMResponseError);
                    return returnMsg;
                }
            }else {
                returnMsg.put('status', Vitality_Constants.ISERRORFLAG);
            	returnMsg.put('SFDCError', Vitality_Constants.ISTRUEFLAG);
            	returnMsg.put('msg', Label.Vitality_RegistrationSFDCError);
            	return returnMsg;
            } 
        }Catch(Exception ex) {
            returnMsg.put('status', Vitality_Constants.ISERRORFLAG);
            returnMsg.put('SFDCError', Vitality_Constants.ISTRUEFLAG);
            returnMsg.put('msg', Label.Vitality_RegistrationSFDCError);
            return returnMsg;
        }
        return null;
    }
    
    public static void createUser(Membership__c memberRecord, String languageCode) {
        Profile prof = [SELECT Id FROM Profile WHERE Name='Customer Community Login User' limit 1];
        if(prof != null) {
            User usr = new User();
            String Email = memberRecord.member__r.Email;
            List<string> nickName = email.split('@');
            String userAlias = memberRecord.member__r.LastName;
            if(userAlias != null) {
                if(userAlias.Length() > 7) {
                    userAlias = userAlias.substring(0,6);
                }else{
                    userAlias = userAlias;
                }
            }
            usr.Alias = userAlias;
            usr.Username = memberRecord.member__r.Email+System.Label.Vitality_UserNameSuffix;
            usr.ContactId = memberRecord.Member__c;
            usr.FirstName = memberRecord.member__r.FirstName;
            usr.LastName = memberRecord.member__r.LastName;
            usr.IsActive = true;
            usr.Email = memberRecord.member__r.Email;
            usr.ProfileId = prof.Id;
            usr.EmailEncodingKey = 'UTF-8';
            if(languageCode.equalsIgnoreCase(Vitality_Constants.LANG_CODE_FRENCH)) {
                usr.LocaleSidKey = Vitality_Constants.LANG_CODE_FRENCH;
            }else {
                usr.LocaleSidKey = Vitality_Constants.LANG_CODE_ENGLISH;
            }
            usr.LanguageLocaleKey = Vitality_Constants.LANG_CODE_ENGLISH;
            usr.TimeZoneSidKey = 'GMT';
            usr.CommunityNickname = nickName[0];
            insert usr;
        }
    }
    
    public static Map<String, String> displayISAMErrorMessage(Map<String, String> errorMessage, Map<String, string> mapResponse, Map<String, String> remoteParam) {
        errorMessage.put('status', Vitality_Constants.ISERRORFLAG);
        errorMessage.put('alreadyRegistered', Vitality_Constants.ISTRUEFLAG);
        /******************Start() - partial English French - Fix : Post Production Issue ******************/
        Map<String, ISAMErrorMessageMapping__c> mpMapping = ISAMErrorMessageMapping__c.getAll();
        if(remoteParam.get('langCode').equalsIgnoreCase(Vitality_Constants.LANG_CODE_FRENCH)) {
            if(mapResponse.get('errors').contains('already')){
                errorMessage.put('msg', mpMapping.get('Registration_UserAlreadyExist').ISAMErrorFrench__c);
            }else if(mapResponse.get('errors').contains('Duplicate')) {
                errorMessage.put('msg', mpMapping.get('Registration_DuplicateUserRegistration').ISAMErrorFrench__c);
            }else {
                errorMessage.put('msg', mapResponse.get('errors'));
            }
        }else {
            errorMessage.put('msg', mapResponse.get('errors'));
        }
        /******************End() - partial English French - Fix : Post Production Issue ******************/
        return errorMessage;
    }
}