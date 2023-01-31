//
//  Extensions.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 30/1/23.
//

import Foundation

extension Data{
    var prettyPrintedJSONString: NSString?{
        guard let object = try? JSONSerialization.jsonObject(with: self,options: []),
              let data = try? JSONSerialization.data(withJSONObject: object,options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else{
            return nil
        }
        return prettyPrintedString
    }
}

extension String {
    var percentEscapeString: String {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return self
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
}
