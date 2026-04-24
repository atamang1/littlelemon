//
//  Home.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/21/26.
//

import SwiftUI

struct Home: View {
    // central hub for managing how app stores, retrieves, and updates data
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            /*Tab("Menu", systemImage: "list.dash") {
                   Menu()
               }*/
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext) //inject a Core Data managed object context into the app's environment
                .tabItem({
                    Label("Menu",
                    systemImage: "list.dash")
                })
            UserProfile()
                .tabItem({
                    Label("Profile",
                          systemImage: "square.and.pencil")
                })
                
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
