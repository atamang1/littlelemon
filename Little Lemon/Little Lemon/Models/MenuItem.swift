//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Ashok Tamang on 4/24/26.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    //optional
    let itemDescription: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case image
        case price
        case category
        case itemDescription = "description"
    }
    
}
