//
//  EditViewModel.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 18/8/22.
//

import Foundation

class EditViewModel: ObservableObject{
    
    @Published var isLoading = false
    
    func apiCallContact(id: Int, completion: @escaping (Contact) -> Void) {
        self.isLoading = true
        AFHttp.get(url: AFHttp.API_CONTACT_SINGLE + String(id), params: AFHttp.paramsContactWith(id: id), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Contact.self, from: response.data!)
                completion(decode)
            case let .failure(error):
                print(error)
                completion(Contact())
            }
        })
    }
    
    func apiEditContact(id: Int, contact: Contact, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + String(id), params: AFHttp.paramsContactUpdate(contact: contact)) { response in
            self.isLoading = false
            switch response.result {
            case .success:
                print("SUCCESS")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil) 
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
}
