//
//  CreateViewModel.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 18/8/22.
//

import Foundation

class CreateViewModel: ObservableObject{
    @Published var isLoading = false
    
    func apiContactCreate(contact: Contact, handler: @escaping (Bool) -> (Void)){
        self.isLoading = true
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact), handler: {response in
            self.isLoading = false
            switch response.result{
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
}
