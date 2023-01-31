//
//  HomeScreen.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 17/8/22.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                    List {
                        ForEach(0..<viewModel.contacts.count, id: \.self) { index in
                            NavigationLink {
                                EditScreen(contactId: viewModel.contacts[index].id ?? "")
                                    .onDisappear{
                                        viewModel.apiContactList()
                                    }
                            } label: {
                                ContactCell(contact: viewModel.contacts[index])
                            }
                        }.onDelete(perform: viewModel.delete)
                }
                .listStyle(PlainListStyle())
                if viewModel.isLoading{
                    ProgressView()
                }
            }
            .navigationBarItems(leading: Button{
                viewModel.apiContactList()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.white)
            }, trailing: NavigationLink(destination: CreateScreen().onDisappear {
                viewModel.apiContactList()
            }
        , label: { Image(systemName: "phone.badge.plus").foregroundColor(.white)
            }))
            .navigationBarTitle("SwiftUI MVVM", displayMode: .inline)
        }
        .onAppear{
            viewModel.apiContactList()
        }
   
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
