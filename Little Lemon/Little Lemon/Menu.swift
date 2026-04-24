//
//  Menu.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/21/26.
//

import SwiftUI

struct Menu: View {
    //Home screen will initialize the Core Data and pass its view context to the Menu instance on initialization
    @Environment(\.managedObjectContext) private var viewContext // allows to access Core Data managed object context directly within a view
    
    // Querying the server
    func getMenuData () {
        // It will make sure that the database is cleared of all
        //the Dish data before fetching and storing the new ones again.
        PersistenceController.shared.clear()
        
        //URL object and force unwrap the URl
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")! //server address
        let request = URLRequest(url: url) // metadata needed to perform a network operation
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data ,
               let responseString = String(data: data,
                                           encoding: .utf8) {
                //print(responseString)
                
                // Parsing response into models using JSONDecoder
                let menuList = try! JSONDecoder().decode(MenuList.self, from: data)
                print("MENU: --------- \(menuList.menu)")
                
                // Save mapped menu items into the database
                for item in menuList.menu {
                    let newDish = Dish(context: viewContext)
                    newDish.title = item.title
                    newDish.image = item.image
                    newDish.price = item.price
                    newDish.itemDescription = item.itemDescription
                    newDish.category = item.category
                }
                
                try? viewContext.save() // save data into the database
               
                
                
            }
            
        }
        
        dataTask.resume() // start the task
        
        
    }
    
    
    var body: some View {
        VStack {
            
            // Head Logo and Profile
            HStack{
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 50)
                    .padding(.horizontal,30)
                Image("Profile-image-placeholder")
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

           //this will fetch all the Dishes from the core data
            // and make them available to use in the closure.
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink(destination: Details(dish: dish)){
                            HStack {
                                
                                Text("\(dish.title ?? "")")
                                Text("\(dish.price ?? "")")
                                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 90, height: 90)

                            }
                        }
                      
                    }
                }
            }
            
            
        }
        .onAppear(){
            getMenuData() //calling method to get the data each time user goes into the menu screen
        }
    }
}

#Preview {
    Menu()
}
