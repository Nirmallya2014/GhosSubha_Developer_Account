//Generated by wsdl2apex

public class ESBApexStub {
    public class BillingEXTProxyPortType {
        public String endpoint_x = 'http://soawsserver:8080/CalculateTaxListESB/ebws/Fetch/CalculateTaxListEXTProxy';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://com.hughes.bits.esb/Billing', 'ESBApexStub', 'http://www.hns.com/iag/schemas/core', 'ESBApexRequest', 'http://www.hns.com/iag/schemas/dssbilling', 'ESBApexResponse'};
        public ESBApexResponse.RefundAccountResponseMsg_element RefundAcctEXTProxyOp(String SAN,Double Amount,String RefundDesc,ESBApexRequest.UserCredentialType UserCredential) {
            ESBApexResponse.RefundAccountMsg_element request_x = new ESBApexResponse.RefundAccountMsg_element();
            request_x.SAN = SAN;
            request_x.Amount = Amount;
            request_x.RefundDesc = RefundDesc;
            request_x.UserCredential = UserCredential;
            ESBApexResponse.RefundAccountResponseMsg_element response_x;
            Map<String, ESBApexResponse.RefundAccountResponseMsg_element> response_map_x = new Map<String, ESBApexResponse.RefundAccountResponseMsg_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://com.hughes.bits.esb/Billing/RefundAcctEXTProxyOp',
              'http://www.hns.com/iag/schemas/dssbilling',
              'RefundAccountMsg',
              'http://www.hns.com/iag/schemas/dssbilling',
              'RefundAccountResponseMsg',
              'ESBApexResponse.RefundAccountResponseMsg_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
        public ESBApexResponse.GetInvoiceListResponseMsg_element GetInvoiceListEXTProxyOp(String SAN) {
            ESBApexResponse.GetInvoiceListMsg_element request_x = new ESBApexResponse.GetInvoiceListMsg_element();
            request_x.SAN = SAN;
            ESBApexResponse.GetInvoiceListResponseMsg_element response_x;
            Map<String, ESBApexResponse.GetInvoiceListResponseMsg_element> response_map_x = new Map<String, ESBApexResponse.GetInvoiceListResponseMsg_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://com.hughes.bits.esb/Billing/GetInvoiceListEXTProxyOp',
              'http://www.hns.com/iag/schemas/dssbilling',
              'GetInvoiceListMsg',
              'http://www.hns.com/iag/schemas/dssbilling',
              'GetInvoiceListResponseMsg',
              'ESBApexResponse.GetInvoiceListResponseMsg_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
        public ESBApexResponse.ValidateCreditCardResponseMsg_element ValidateCreditCardOp(ESBApexRequest.CreditCardType CreditCard,Boolean ValidateOnly,Double AuthAmount,Boolean IsUpfrontCharge,String UpfrontChargeTransId,ESBApexRequest.AddressType InstallAddress) {
            ESBApexResponse.ValidateCreditCardMsg_element request_x = new ESBApexResponse.ValidateCreditCardMsg_element();
            request_x.CreditCard = CreditCard;
            request_x.ValidateOnly = ValidateOnly;
            request_x.AuthAmount = AuthAmount;
            request_x.IsUpfrontCharge = IsUpfrontCharge;
            request_x.UpfrontChargeTransId = UpfrontChargeTransId;
            request_x.InstallAddress = InstallAddress;
            ESBApexResponse.ValidateCreditCardResponseMsg_element response_x;
            Map<String, ESBApexResponse.ValidateCreditCardResponseMsg_element> response_map_x = new Map<String, ESBApexResponse.ValidateCreditCardResponseMsg_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://com.hughes.bits.esb/Billing/ValidateCreditCardOp',
              'http://www.hns.com/iag/schemas/dssbilling',
              'ValidateCreditCardMsg',
              'http://www.hns.com/iag/schemas/dssbilling',
              'ValidateCreditCardResponseMsg',
              'ESBApexResponse.ValidateCreditCardResponseMsg_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
        public ESBApexResponse.CalculateTaxSOListResponseMsg_element CalculateTaxListEXTProxyOp(ESBApexRequest.AddressType FromAddress,ESBApexRequest.AddressType ToAddress,ESBApexRequest.AddressType OrderAcceptAddress,ESBApexResponse.TaxSOCalculationType[] TaxSOCalculationValues) {
            ESBApexResponse.CalculateTaxSOListMsg_element request_x = new ESBApexResponse.CalculateTaxSOListMsg_element();
            request_x.FromAddress = FromAddress;
            request_x.ToAddress = ToAddress;
            request_x.OrderAcceptAddress = OrderAcceptAddress;
            request_x.TaxSOCalculationValues = TaxSOCalculationValues;
            ESBApexResponse.CalculateTaxSOListResponseMsg_element response_x;
            Map<String, ESBApexResponse.CalculateTaxSOListResponseMsg_element> response_map_x = new Map<String, ESBApexResponse.CalculateTaxSOListResponseMsg_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://com.hughes.bits.esb/Billing/CalculateTaxListEXTProxyOp',
              'http://www.hns.com/iag/schemas/dssbilling',
              'CalculateTaxSOListMsg',
              'http://www.hns.com/iag/schemas/dssbilling',
              'CalculateTaxSOListResponseMsg',
              'ESBApexResponse.CalculateTaxSOListResponseMsg_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
        public ESBApexResponse.ChargeCreditCardResponseMsg_element ChargeCreditCardEXTProxyOp(String SAN,Double AuthAmount,ESBApexRequest.UserCredentialType UserCredential,ESBApexRequest.CreditCardType CreditCard,Boolean StoreOnAccount) {
            ESBApexResponse.ChargeCreditCardMsg_element request_x = new ESBApexResponse.ChargeCreditCardMsg_element();
            request_x.SAN = SAN;
            request_x.AuthAmount = AuthAmount;
            request_x.UserCredential = UserCredential;
            request_x.CreditCard = CreditCard;
            request_x.StoreOnAccount = StoreOnAccount;
            ESBApexResponse.ChargeCreditCardResponseMsg_element response_x;
            Map<String, ESBApexResponse.ChargeCreditCardResponseMsg_element> response_map_x = new Map<String, ESBApexResponse.ChargeCreditCardResponseMsg_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://com.hughes.bits.esb/Billing/ChargeCreditCardEXTProxyOp',
              'http://www.hns.com/iag/schemas/dssbilling',
              'ChargeCreditCardMsg',
              'http://www.hns.com/iag/schemas/dssbilling',
              'ChargeCreditCardResponseMsg',
              'ESBApexResponse.ChargeCreditCardResponseMsg_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x;
        }
    }
}