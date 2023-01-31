//
//  CreateViewModel.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 18/8/22.
//

import Foundation
import Combine

class CreateViewModel: ObservableObject{
    private var anyCancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    
    func apiContactCreate(contact: Contact){
        self.isLoading = true
        CombineService.createContact(name: contact.name ?? "Optional name", phone: contact.phone ?? "Optional phone")
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                    self?.isLoading = true
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                print(response)
                self.isLoading = false
            }
            .store(in: &anyCancellables)
    }
}
