//
//  CreateScreen.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 17/8/22.
//

import SwiftUI

struct CreateScreen: View {
    @StateObject var viewModel = CreateViewModel()
    @Environment(\.presentationMode) var presentation
    @State var createName = ""
    @State var createPhone = ""
    
    var body: some View {
            ZStack{
                VStack(alignment: .leading){
                    TextField("Name", text: $createName)
                        .padding(.leading)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.gray))
                    TextField("Phone", text: $createPhone)
                        .padding(.leading)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.gray))
                    Button{
                        viewModel.apiContactCreate(contact: Contact(name: createName, phone: createPhone))
                        presentation.wrappedValue.dismiss()
                    }label: {
                        Text("Create")
                            .frame(maxWidth: .infinity,maxHeight: 50)
                            .foregroundColor(.white)
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                    Spacer()
                }
                .padding()
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("Create Screen", displayMode: .inline)
            .navigationBarItems(leading: Button{
                presentation.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
            })
        .navigationBarBackButtonHidden(true)
        
    }
}

struct CreateScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateScreen()
    }
}
