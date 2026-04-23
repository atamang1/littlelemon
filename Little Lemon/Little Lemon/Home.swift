//
//  Home.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/21/26.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            /*Tab("Menu", systemImage: "list.dash") {
                   Menu()
               }*/
            Menu()
                .tabItem({
                    Label("Menu",
                    systemImage: "list.dash")
                })
                
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
