//
//  Menu.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/21/26.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            // Head Logo and Profile
            HStack{
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 50)
                    .padding(.horizontal,30)
                Image("Profile")
                    .resizable()
                    .frame(width: 70, height: 70)
            }
            // About Restaurant
            VStack(alignment: .leading){
                Text("Little Lemon")
                    .font(.system(size: 64))
                Text("Chicago")
                    .font(.system(size: 40))
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.system(size: 18))
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color.green)

           //List of menu items
            List {
                
            }
            
            
        }
    }
}

#Preview {
    Menu()
}
