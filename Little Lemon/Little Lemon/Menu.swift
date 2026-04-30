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
    
    //to store search input
   @State var searchText = ""
    @State var activeCategory:String? = nil // keep track of category button press

    var categories = ["Starters", "Mains", "Desserts", "Sides"]
    
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
    
    //this function returns a predicte to filter the FetchedObjects result
    func buildPredicate (category: String) -> NSPredicate {
        //if search text is empty then show all list
        if searchText.isEmpty && category.isEmpty {
            return NSPredicate(value: true)
        }
        
        // 2. If searching but no category selected
           if !searchText.isEmpty && category.isEmpty {
               return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
           }
        
        // 3. If category is selected but no search text
            if searchText.isEmpty && !category.isEmpty {
                return NSPredicate(format: "category == %@", category.lowercased())
            }
           
        // return only list that matches the search text
        return NSPredicate(format: "title CONTAINS[cd] %@ AND category == %@", searchText, category.lowercased())
    }
    
    
    //Sorting by name
    //returns an array or sort descriptors for Dish objects
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(
            key: "title",
            ascending: true,
            selector: #selector(NSString.localizedStandardCompare)
        )]
    }
    
    /*
    // filter by categories
    func categorySortPredicate ( _ category: String) -> NSPredicate {
        // if argumentis empty then show all list
        if category.isEmpty {
            return NSPredicate(value: true)
        }
        
        // return only list that matches the exact category
        return NSPredicate(format: "category == %@", category.lowercased())
    }
     */
    
    
    var body: some View {
        VStack(){
            
            // Head Logo and Profile
            HStack{
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 30)
                    .padding(.horizontal,30)
                Spacer()
                Image("Profile-image-placeholder")
                    .resizable()
                    .frame(width: 30, height: 30)
                    
            }
            .padding(10)
            .frame(height: 30)
            // About Restaurant
            VStack(alignment: .leading, spacing: 0){
                
                Text("Little lemon")
                    .font(.custom("MarkaziText-Medium", size: 64))
                    .foregroundColor(.yellow)
                    .padding(0)
                Text("Chicago")
                    .font(.custom("MarkaziText-Regular", size: 40))
                    .padding(.top, -10)
                
                    //.font(.system(size: 40))
                
                // About description and Hero image
                HStack{
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.custom("Karla-Medium", size: 18))
                        .fixedSize(horizontal: false, vertical: true) // Forces it to expand vertically to fit the text
                        .padding(.top, -20)
                    Spacer()
                    
                    Image("Hero image")
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 168, height: 153)

                }
                .padding(0)
                
                // Search menu text field
                HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(10)
                    
                    TextField("Search menu", text: $searchText)
                        .foregroundColor(.black)
                        .frame(height: 40)
                }
                .background(Color.white)
                .cornerRadius(8)
                .padding(.bottom, 10)
                .padding(.top, 10)
                
            }
            .padding(10)
            .background(Color.primaryGreen)
            .frame(maxHeight: .infinity)
            
            //Tapable Categories
            VStack(alignment: .leading) {
                Text("ORDER FOR DELIVERY! ")
                    .font(.custom("Karla-ExtraBold", size: 20))
               
                //Categories
                HStack(spacing: 20){
                    /*
                    Toggle("Starter", isOn: $isHighlighted)
                        .toggleStyle(.button) // Makes it look and behave like a persistent button
                        .tint(.blue) // Changes the highlight color
                        .font(.custom("Karla-Medium", size: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 2)
                                .frame(width: 80, height: 30)
                        }
                     */
                    
                    ForEach(categories, id: \.self) { category in
                        Button(category) {
                            // If this button is already the active one, turn it off
                            activeCategory = (activeCategory == category) ? nil: category
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(activeCategory == category ? .blue : .gray)
                        .disabled(activeCategory != nil && activeCategory != category)
                       
                    }
                        
                }
            }
           
           //this will fetch all the Dishes from the core data
            // and make them available to use in the closure.
            FetchedObjects(predicate: buildPredicate(category: activeCategory ?? ""), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink(destination: Details(dish: dish)){
                            HStack {
                                VStack(alignment: .leading){
                                    Text("\(dish.title ?? "")")
                                    Text("$" + "\(dish.price ?? "")")
                                }
                              
                                Spacer()
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
            PersistenceController.shared.clear()
            getMenuData() //calling method to get the data each time user goes into the menu screen
        }
    }
}

#Preview {
    Menu()
}
