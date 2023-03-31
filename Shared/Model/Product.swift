//
//  Product.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 27/11/21.
//

import SwiftUI

// Product Model....
struct Product: Identifiable,Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
    var productId: String = ""
    var sellingPrice: NSDecimalNumber = 1.00
}

// Product Types...
enum ProductType: String,CaseIterable{
    //case Wearable = "Wearable"
    //case Laptops = "Laptops"
    //case Phones = "Phones"
    //case Tablets = "Tablets"
    case Astronaut = "Astronaut"
    case Baby = "Baby"
    case Bear = "Bear"
    case Bird = "Bird"
    case Blue = "Blue"
    case Cute = "Cute"
    case Fluff = "Fluff"
    case Gears = "Gears"
    case Gold = "Gold"
    case Green = "Green"
    case Pink = "Pink"
    case Purple = "Purple"
    case Rainbow = "Rainbow"
    case Red = "Red"
    case Royal = "Royal"
    case Scales = "Scales"
    case Teal = "Teal"
    case Tiger = "Tiger"
    case Yellow = "Yellow"
}

