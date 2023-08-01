//
//  AES256Util.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Foundation
import CryptoSwift

//class AES256Util {
//    static func encrypt(string: String) -> String? {
//        guard !string.isEmpty else { return nil }
//        return try! getAESObject().encrypt(string.bytes).toBase64()
//    }
//    
//    static func decrypt(encoded: String) -> String? {
//        let datas = Data(base64Encoded: encoded)
//        
//        guard datas != nil else {
//            return nil
//        }
//        
//        let bytes = datas!.bytes
//        let decode = try! getAESObject().decrypt(bytes)
//        
//        return String(bytes: decode, encoding: .utf8)
//    }
//    
//    private static func getAESObject() -> AES{
//        let keyDecodes : Array<UInt8> = Array(DataManager.shared.key256.utf8)
//        let ivDecodes : Array<UInt8> = Array(DataManager.shared.iv.utf8)
//        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
//        
//        return aesObject
//    }
//}
