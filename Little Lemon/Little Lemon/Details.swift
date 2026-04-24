//
//  Details.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/24/26.
//

import SwiftUI

struct Details: View {
     var dish: Dish
    var body: some View {
        VStack {
            // Dish details
            Text(dish.title ?? "")
                .font(.system(size: 40))
                .fontWeight(.medium)
            
            AsyncImage(url: URL(string: dish.image ?? "")){ image in
                
                image.resizable()
                    .scaledToFill()
                    .clipShape( RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            Text(dish.category?.capitalized ?? "")
            Text(dish.itemDescription ?? "")
            Spacer()
        }
        .padding(20)
        
    }
}

#Preview {
   // Details("dish")
}
 
