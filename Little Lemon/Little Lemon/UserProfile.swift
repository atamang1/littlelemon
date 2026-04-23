//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/23/26.
//

import SwiftUI

struct UserProfile: View {
    
    // This will automatically reference the presentation environment in swiftui which will allow you to reach the navgiation logic
    @Environment(\.presentationMode) var presentationMode
    
    //Accessing the standard property of UserDefaults and
    //calling string method on it.
    //Use the key for the first name defined at the top of the Onboarding file.
    let firstName = UserDefaults.standard.string(forKey: "first name key") ?? ""
    let lastName = UserDefaults.standard.string(forKey: "last name key") ?? ""
    let email = UserDefaults.standard.string(forKey: "email key") ?? ""
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("Profile-image-placeholder")
            HStack {
                Text(firstName)
                Text(lastName)
            }
            Text(email)
            
            Button("Logout") {
                //set loggin to false
                UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                // call dismiss
                self.presentationMode.wrappedValue.dismiss()
            }
            Spacer()
            
        }
    }
}

#Preview {
    UserProfile()
}
