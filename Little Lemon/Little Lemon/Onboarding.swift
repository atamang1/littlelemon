//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/18/26.
//

import SwiftUI

//Global constants
//for the keys in UserDefaults to store and access
let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"


struct Onboarding: View {
    //State variables to hold users input
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var email:String = ""
    @State var isLoggedIn:Bool = false
    
    // helper function to validate email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    var body: some View {
        //Login
        NavigationStack {
            VStack {
                //Little lemon logo
                Image("Little Lemon logo")
                    .resizable()
                    .frame(width: 150, height: 220)
                    .padding(.bottom, 14)
                
                // Take users input
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                
                //Button to complete the registration
                Button("Register") {
                    if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty ) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        
                        if(isValidEmail(email)) {
                            UserDefaults.standard.set(email, forKey: kEmail)
                        }
                        
                        isLoggedIn = true
                        UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
                            
                    }
                }
                .frame(maxWidth: 250)
                .padding()
                .background(Color.blue.opacity(1))
                .border(Color.blue.opacity(0.1), width: 1)
                .cornerRadius(10)
                .foregroundColor(.primaryColor1)
                
                
            }
            .textFieldStyle(myTextFieldStyle())
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear(){
                // check if user already logged in
                if UserDefaults.standard.bool(forKey: "kIsLoggedIn") {
                    isLoggedIn = true
                }
            }
            
        }
        

    }
}

#Preview {
    Onboarding()
}
