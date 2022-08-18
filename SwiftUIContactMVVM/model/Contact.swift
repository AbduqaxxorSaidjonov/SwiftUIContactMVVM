//
//  Contact.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 17/8/22.
//

import Foundation

struct Contact: Hashable, Decodable{
    var id: String?
    var name: String?
    var phone: String?
    
    init(){
        
    }
    
    init(name: String?, phone: String?){
        self.name = name
        self.phone = phone
    }
}
