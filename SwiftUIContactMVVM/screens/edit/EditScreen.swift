//
//  EditScreen.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 17/8/22.
//

import SwiftUI

struct EditScreen: View {
    
    @Environment(\.presentationMode) var presentation
    @State var editName = ""
    @State var editPhone = ""
    @ObservedObject var viewModel = EditViewModel()
    var contactId: String
    
    var body: some View {
            ZStack{
                VStack(alignment: .leading,spacing: 15){
                   TextField("Name", text: $editName)
                        .padding(.leading)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.gray))
                   TextField("Phone", text: $editPhone)
                        .padding(.leading)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.gray))
                    Button{
                        viewModel.apiEditContact(id: contactId, name: editName, phone: editPhone) { result in
                            if result {
                                presentation.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                    Spacer()
                }
                .padding()
                if viewModel.isLoading{
                    ProgressView()
                }
            }
            .navigationBarTitle("Edit Screen", displayMode: .inline)
            .navigationBarItems(leading: Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
            })
            .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.apiCallContact(id: contactId) { item in
                self.editName = item.name ?? ""
                self.editPhone = item.phone ?? ""
            }

        }
        
   
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(contactId: "")
    }
}
