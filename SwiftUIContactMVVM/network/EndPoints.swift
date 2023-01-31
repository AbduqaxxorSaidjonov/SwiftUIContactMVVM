//
//  EndPoints.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 30/1/23.
//

import Foundation

public enum EndPoints: EndPointType {
    
    case getContacts
    case deleteContact(id: String)
    case createContact(name: String, phone: String)
    case getSingleContact(id: String)
    case editContact(id: String, name: String, phone: String)
    
    public var scheme: String {
        switch self {
        default:
            return Consts.baseScheme
        }
    }
    
    public var baseUrl: String {
        switch self {
        default:
            return Consts.baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .getContacts, .createContact(_, _):
            return "/api/contacts"
        case .deleteContact(let id), .editContact(let id, _, _), .getSingleContact(let id):
            return "/api/contacts/" + id
        }
    }
    
    public var method: String {
        switch self {
        case .getContacts, .getSingleContact(_):
            return HTTPMethod.get
        case .createContact(_, _):
            return HTTPMethod.post
        case .editContact(_, _, _):
            return HTTPMethod.put
        case .deleteContact(_):
            return HTTPMethod.del
        }
    }
    
    public var body: Data {
        switch self {
        case .createContact(let name, let phone), .editContact(_, let name, let phone):
            let data = [
                "name": name,
                "phone": phone
            ]
            return encodeParameters(parameters: data) ?? Data()
        default:
            return Data()
        }
    }
    
    func encodeParameters(parameters: [String : String]) -> Data? {
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(value.percentEscapeString)"
        }
        
        return parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}
