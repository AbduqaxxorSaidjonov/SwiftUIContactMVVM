//
//  EditViewModel.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 18/8/22.
//

import Foundation
import Combine

class EditViewModel: ObservableObject{
    
    private var anyCancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    
    func apiCallContact(id: String, completion: @escaping (Contact) -> Void) {
        self.isLoading = true
        
        CombineService.getSingleContact(id: id)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self?.isLoading = true
                }
            } receiveValue: { [weak self] response in
                guard let this = self else { return }
                completion(response)
                this.isLoading = false
            }
            .store(in: &anyCancellables)
    }
    
    func apiEditContact(id: String, name: String, phone: String, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        CombineService.editContact(id: id, name: name, phone: phone)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self?.isLoading = true
                }
            } receiveValue: { [weak self] response in
                guard let this = self else { return }
                completion(true)
                this.isLoading = false
                print(response)
            }
            .store(in: &anyCancellables)
    }
}
