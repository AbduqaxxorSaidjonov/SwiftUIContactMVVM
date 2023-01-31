//
//  HomeViewModel.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 17/8/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    private var anyCancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var contacts = [Contact]()
    
    func apiContactList(){
        self.isLoading = true
        CombineService.getContacts()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self?.isLoading = true
                }
            } receiveValue: { [weak self] response in
                guard let this = self else { return }
                if !response.isEmpty {
                    this.contacts = response.self
                    self?.isLoading = false
                }
            }
            .store(in: &anyCancellables)
    }
    
    func apiContactDelete(contact: Contact){
        isLoading = true
        CombineService.deleteContact(id: contact.id ?? "")
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self?.isLoading = true
                }
            } receiveValue: { [weak self] response in
                print(response)
                self?.isLoading = false
                self?.apiContactList()
            }
            .store(in: &anyCancellables)
    }
    
    func delete(indexSet: IndexSet){
        let contact = contacts[indexSet.first!]
        apiContactDelete(contact: contact)
    }
}
