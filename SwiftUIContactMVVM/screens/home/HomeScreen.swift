//
//  HomeScreen.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 17/8/22.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showingEdit = false
    
    func delete(indexSet: IndexSet){
        let contact = viewModel.contacts[indexSet.first!]
        viewModel.apiContactDelete(contact: contact, handler: { value in
            if value {
                viewModel.apiContactList()
            }
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(0..<viewModel.contacts.count, id:\.self) { index in
                        Button {
                            showingEdit.toggle()
                        } label: {
                            ContactCell(contact: viewModel.contacts[index])
                        }
                        .sheet(isPresented: $showingEdit){
                            EditScreen(contactId: viewModel.contacts[index].id!)
                                .onDisappear{
                                    viewModel.apiContactList()
                                }
                        }
                    }.onDelete(perform: delete)
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
            }, trailing: NavigationLink(destination: CreateScreen()
        , label: { Image(systemName: "note.text.badge.plus").foregroundColor(.white)
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
