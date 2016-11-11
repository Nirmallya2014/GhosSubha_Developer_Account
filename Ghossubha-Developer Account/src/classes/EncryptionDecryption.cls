public class EncryptionDecryption {
    
    public static String encryptData(String beforeEncryptedText) {
        Blob key = Blob.valueOf(CryptoKey__c.getValues('CryptoKey').DataModel__Crypto_Key__c);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', key , Blob.valueOf(beforeEncryptedText));
        String encrypted= EncodingUtil.base64Encode(encryptedData);
        system.debug(LoggingLevel.INFO, encrypted);
        return encrypted;
    }
    
    public static void decryptData(String afterEncryptedText) {
        Blob key = Blob.valueOf(CryptoKey__c.getValues('CryptoKey').DataModel__Crypto_Key__c);
        Blob b = EncodingUtil.base64Decode(afterEncryptedText);
        Blob decodeCipherText=Crypto.decryptWithManagedIV('AES128', key, b);
        String decodedCipherText = decodeCipherText.toString();
        system.debug(LoggingLevel.INFO, decodedCipherText);
    }
}