//
//  CombineService.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 30/1/23.
//

import Foundation
import Combine

struct CombineService {
    static func getContacts() -> AnyPublisher<[Contact], Error> {
        ApiService.shared.get(endpoint: EndPoints.getContacts, objectType: [Contact].self)
    }
    
    static func deleteContact(id: String) -> AnyPublisher<Contact, Error> {
        ApiService.shared.get(endpoint: EndPoints.deleteContact(id: id), objectType: Contact.self)
    }
    
    static func createContact(name: String, phone: String) -> AnyPublisher<Contact, Error> {
        ApiService.shared.get(endpoint: EndPoints.createContact(name: name, phone: phone), objectType: Contact.self)
    }
    
    static func getSingleContact(id: String) -> AnyPublisher<Contact, Error> {
        ApiService.shared.get(endpoint: EndPoints.getSingleContact(id: id), objectType: Contact.self)
    }
    
    static func editContact(id: String, name: String, phone: String) -> AnyPublisher<Contact, Error> {
        ApiService.shared.get(endpoint: EndPoints.editContact(id: id, name: name, phone: phone), objectType: Contact.self)
    }
    
}
