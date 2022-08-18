//
//  SwiftUIContactMVVMApp.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 17/8/22.
//

import SwiftUI

@main
struct SwiftUIContactMVVMApp: App {
    let persistenceController = PersistenceController.shared

    init(){
        UINavigationBar.appearance().backgroundColor = UIColor.gray
        UINavigationBar.appearance().barTintColor = UIColor.gray
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().isTranslucent = true
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
