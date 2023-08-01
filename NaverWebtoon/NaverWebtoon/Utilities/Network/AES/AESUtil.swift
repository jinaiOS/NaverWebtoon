//
//  AESUtil.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

//import Foundation
//import CommonCrypto
//
//struct AESUtil {
//    
//    // MARK: - Value
//    // MARK: Private
//    private let key: Data
//    private let iv: Data
//    
//    
//    // MARK: - Initialzier
//    init?(key: String, iv: String) {
//        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256, let keyData = key.data(using: .utf8) else {
//            Log.d("Error: Failed to set a key.")
//            return nil
//        }
//        
//        guard iv.count == kCCBlockSizeAES128, let ivData = iv.data(using: .utf8) else {
//            Log.d("Error: Failed to set an initial vector.")
//            return nil
//        }
//        
//        
//        self.key = keyData
//        self.iv  = ivData
//    }
//    
//    
//    // MARK: - Function
//    // MARK: Public
//    private func encrypt(string: String?) -> Data? {
//        return crypt(data: string?.data(using: .utf8), option: CCOperation(kCCEncrypt))
//    }
//    
//    private func decrypt(data: Data?) -> String? {
//        guard let decryptedData = crypt(data: data, option: CCOperation(kCCDecrypt)) else { return nil }
//        return String(bytes: decryptedData, encoding: .utf8)
//    }
//    
//    private func crypt(data: Data?, option: CCOperation) -> Data? {
//        guard let data = data else { return nil }
//        
//        let cryptLength = [UInt8](repeating: 0, count: data.count + kCCBlockSizeAES128).count
//        var cryptData   = Data(count: cryptLength)
//        
//        let keyLength = [UInt8](repeating: 0, count: kCCBlockSizeAES128).count
//        let options   = CCOptions(kCCOptionPKCS7Padding)
//        
//        var bytesLength = Int(0)
//        
//        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
//            data.withUnsafeBytes { dataBytes in
//                iv.withUnsafeBytes { ivBytes in
//                    key.withUnsafeBytes { keyBytes in
//                        CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes, keyLength, ivBytes, dataBytes, data.count, cryptBytes, cryptLength, &bytesLength)
//                    }
//                }
//            }
//        }
//        
//        guard UInt32(status) == UInt32(kCCSuccess) else {
//            Log.d("Error: Failed to crypt data. Status \(status)")
//            return nil
//        }
//        
//        cryptData.removeSubrange(bytesLength..<cryptData.count)
//        return cryptData
//    }
//    
//    static func aes128Encrypt(str : String?) -> Data? {
//        let aes128 = AESUtil(key: DataManager.shared.key128, iv: DataManager.shared.iv)
//        return aes128?.encrypt(string: str)
//    }
//    
//    static func aes256Encrypt(str : String?) -> Data? {
//        let aes256 = AESUtil(key: DataManager.shared.key256, iv: DataManager.shared.iv)
//        return aes256?.encrypt(string: str)
//    }
//    
//    static func aes128Decrypt(data : Data?) -> String? {
//        let aes128 = AESUtil(key: DataManager.shared.key128, iv: DataManager.shared.iv)
//        return aes128?.decrypt(data: data)
//    }
//    
//    static func aes256Decrypt(data : Data?) -> String? {
//        let aes256 = AESUtil(key: DataManager.shared.key256, iv: DataManager.shared.iv)
//        return aes256?.decrypt(data: data)
//    }
//    /**
//       
//       @brief Aes128로 암호화
//       
//       @return Data
//       */
//      static func encrypt128(str : String) -> String?{
//          let key128   = DataManager.shared.key128
//          let iv       = DataManager.shared.iv
//          let aes128 = AESUtil(key: key128, iv: iv)
//          guard let encryptedData = aes128?.encrypt(string: str) else {
//              return nil
//          }
//          var result = ""
//          
//          result = encryptedData.base64EncodedString(options: [])
//          
//          
//          return result
//      }
//      
//      /**
//       
//       @brief Aes128로 복호화
//       
//       @return String
//       */
//      static func decrypt128(str : String) -> String?{
//          let data = Data(base64Encoded: str, options: NSData.Base64DecodingOptions(rawValue: 0))
//          let key128   = DataManager.shared.key128
//          let iv       = DataManager.shared.iv
//          let aes128 = AESUtil(key: key128, iv: iv)
//          let decryptedString = aes128?.decrypt(data: data)
//          return decryptedString
//      }
//}
///** use like this
// let password = "UserPassword1!"
// let key128   = "1234567890123456"                   // 16 bytes for AES128
// let key256   = "12345678901234561234567890123456"   // 32 bytes for AES256
// let iv       = "abcdefghijklmnop"                   // 16 bytes for AES128
// 
// let aes128 = AES(key: key128, iv: iv)
// let aes256 = AES(key: key256, iv: iv)
// 
// let encryptedPassword128 = aes128?.encrypt(string: password)
// aes128?.decrypt(data: encryptedPassword128)
// 
// let encryptedPassword256 = aes256?.encrypt(string: password)
// aes256?.decrypt(data: encryptedPassword256)
// **/
