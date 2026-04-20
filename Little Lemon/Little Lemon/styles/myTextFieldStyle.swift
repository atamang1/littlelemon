//
//  textFieldStyle.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/19/26.
//

import SwiftUI

struct myTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.blue.opacity(0.5), lineWidth: 1)
                    .background(Color.blue.opacity(0.05))
            )
            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            
    }
}

// 2. The Preview
#Preview {
    // Since TextField needs a Binding, we use @Previewable (Xcode 16+)
    // or a simple wrapper View.
    VStack(spacing: 20) {
        TextField("Type here...", text: .constant(""))
            .textFieldStyle(myTextFieldStyle())
        
        TextField("Example with text", text: .constant("Hello SwiftUI!"))
            .textFieldStyle(myTextFieldStyle())
    }
    .padding()
}
