//
//  HomeViewModel.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 27/11/21.
//

import SwiftUI

// Using Combine to monitor search field and if user leaves for .5 secs then starts searching...
// to avoid memory issue...
import Combine

class HomeViewModel: ObservableObject {

    @Published var productType: ProductType = .Astronaut
    
    // Sample Products...
    @Published var products: [Product] = [
    
        //Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359",productImage: "AppleWatch6", productId: "applewatch6red", sellingPrice: 359.00),
        //Product(type: .Wearable, title: "Samsung Watch", subtitle: "Gear: Black", price: "$180", productImage: "SamsungWatch", productId: "samsungwatchgearblack", sellingPrice: 180.00),
        //Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 4: Black", price: "$250", productImage: "AppleWatch4", productId: "applewatch4black", sellingPrice: 250.00),
        //Product(type: .Phones, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699", productImage: "iPhone13", productId: "iphone13pink", sellingPrice: 699.00),
        //Product(type: .Phones, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599", productImage: "iPhone12", productId: "iphone12blue", sellingPrice: 599.00),
        //Product(type: .Phones, title: "iPhone 11", subtitle: "A13 - Purple", price: "$499", productImage: "iPhone11", productId: "iphone11purple", sellingPrice: 499.00),
        //Product(type: .Phones, title: "iPhone SE 2", subtitle: "A13 - White", price: "$399", productImage: "iPhoneSE", productId: "iphonese2white", sellingPrice: 399.00),
        //Product(type: .Laptops, title: "MacBook Air", subtitle: "M1 - Gold", price: "$999", productImage: "MacBookAir", productId: "macbookairgold", sellingPrice: 999.00),
        //Product(type: .Laptops, title: "MacBook Pro", subtitle: "M1 - Space Grey", price: "$1299", productImage: "MacBookPro", productId: "macbookprospacegrey", sellingPrice: 1299.00),
        //Product(type: .Tablets, title: "iPad Pro", subtitle: "M1 - Silver", price: "$999", productImage: "iPadPro", productId: "ipadprosilver", sellingPrice: 999.00),
        //Product(type: .Tablets, title: "iPad Air 4", subtitle: "A14 - Pink", price: "$699", productImage: "iPadAir", productId: "ipadair4pink", sellingPrice: 699.00),
        //Product(type: .Tablets, title: "iPad Mini", subtitle: "A15 - Grey", price: "$599", productImage: "iPadMini", productId: "ipadminigrey", sellingPrice: 599.00),
        //Product(type: .Laptops, title: "iMac", subtitle: "M1 - Purple", price: "$1599", productImage: "iMac", productId: "imacpurple", sellingPrice: 1599.00),
        
        Product(type: .Astronaut, title: "Astrocreep", subtitle: "Astronaut Monster", price: "$5", productImage: "astronaut-1", productId: "astronaut-1", sellingPrice: 5.00),
        Product(type: .Astronaut, title: "Starbeast", subtitle: "Astronaut Monster", price: "$5", productImage: "astronaut-2", productId: "astronaut-2", sellingPrice: 5.00),
        Product(type: .Astronaut, title: "Cosmic Critter", subtitle: "Astronaut Monster", price: "$5", productImage: "astronaut-3", productId: "astronaut-3", sellingPrice: 5.00),
        Product(type: .Astronaut, title: "Galaxy Gobbler", subtitle: "Astronaut Monster", price: "$5", productImage: "astronaut-4", productId: "astronaut-4", sellingPrice: 5.00),
        Product(type: .Baby, title: "Cuddlekins", subtitle: "Baby Monster", price: "$5", productImage: "baby-1", productId: "baby-1", sellingPrice: 5.00),
        Product(type: .Baby, title: "Pipsqueak", subtitle: "Baby Monster", price: "$5", productImage: "baby-2", productId: "baby-2", sellingPrice: 5.00),
        Product(type: .Baby, title: "Snugglebug", subtitle: "Baby Monster", price: "$5", productImage: "baby-3", productId: "baby-3", sellingPrice: 5.00),
        Product(type: .Baby, title: "Little Critter", subtitle: "Baby Monster", price: "$5", productImage: "baby-4", productId: "baby-4", sellingPrice: 5.00),
        Product(type: .Bear, title: "Grizzlygeist", subtitle: "Bear Monster", price: "$5", productImage: "bear-1", productId: "bear-1", sellingPrice: 5.00),
        Product(type: .Bear, title: "Kodiakiller", subtitle: "Bear Monster", price: "$5", productImage: "bear-2", productId: "bear-2", sellingPrice: 5.00),
        Product(type: .Bear, title: "Polar Predator", subtitle: "Bear Monster", price: "$5", productImage: "bear-3", productId: "bear-3", sellingPrice: 5.00),
        Product(type: .Bear, title: "Fuzzy Fury", subtitle: "Bear Monster", price: "$5", productImage: "bear-4", productId: "bear-4", sellingPrice: 5.00),
        Product(type: .Bird, title: "Talon Terror", subtitle: "Bird Monster", price: "$5", productImage: "bird-1", productId: "bird-1", sellingPrice: 5.00),
        Product(type: .Bird, title: "Winged Warrior", subtitle: "Bird Monster", price: "$5", productImage: "bird-2", productId: "bird-2", sellingPrice: 5.00),
        Product(type: .Bird, title: "Beak Beast", subtitle: "Bird Monster", price: "$5", productImage: "bird-3", productId: "bird-3", sellingPrice: 5.00),
        Product(type: .Bird, title: "Flapping Fury", subtitle: "Bird Monster", price: "$5", productImage: "bird-4", productId: "bird-4", sellingPrice: 5.00),
        Product(type: .Blue, title: "Blue Bolt", subtitle: "Blue Monster", price: "$5", productImage: "blue-1", productId: "blue-1", sellingPrice: 5.00),
        Product(type: .Blue, title: "Azure Avenger", subtitle: "Blue Monster", price: "$5", productImage: "blue-2", productId: "blue-2", sellingPrice: 5.00),
        Product(type: .Blue, title: "Blue Banshee", subtitle: "Blue Monster", price: "$5", productImage: "blue-3", productId: "blue-3", sellingPrice: 5.00),
        Product(type: .Blue, title: "Blueback Beast", subtitle: "Blue Monster", price: "$5", productImage: "blue-4", productId: "blue-4", sellingPrice: 5.00),
        Product(type: .Cute, title: "Adorable Abomination", subtitle: "Cute Monster", price: "$5", productImage: "cute-1", productId: "cute-1", sellingPrice: 5.00),
        Product(type: .Cute, title: "Cuddlebug", subtitle: "Cute Monster", price: "$5", productImage: "cute-2", productId: "cute-2", sellingPrice: 5.00),
        Product(type: .Cute, title: "Sweetheart Slasher", subtitle: "Cute Monster", price: "$5", productImage: "cute-3", productId: "cute-3", sellingPrice: 5.00),
        Product(type: .Cute, title: "Cutesy Crawler", subtitle: "Cute Monster", price: "$5", productImage: "cute-4", productId: "cute-4", sellingPrice: 5.00),
        Product(type: .Fluff, title: "Fluffernutter", subtitle: "Fluff Monster", price: "$5", productImage: "fluff-1", productId: "fluff-1", sellingPrice: 5.00),
        Product(type: .Fluff, title: "Fuzzball", subtitle: "Fluff Monster", price: "$5", productImage: "fluff-2", productId: "fluff-2", sellingPrice: 5.00),
        Product(type: .Fluff, title: "Puff Puff", subtitle: "Fluff Monster", price: "$5", productImage: "fluff-3", productId: "fluff-3", sellingPrice: 5.00),
        Product(type: .Fluff, title: "Furry Fuzz", subtitle: "Fluff Monster", price: "$5", productImage: "fluff-4", productId: "fluff-4", sellingPrice: 5.00),
        Product(type: .Gears, title: "Cog Crusher", subtitle: "Gears Monster", price: "$5", productImage: "gears-1", productId: "gears-1", sellingPrice: 5.00),
        Product(type: .Gears, title: "Gear Grinder", subtitle: "Gears Monster", price: "$5", productImage: "gears-2", productId: "gears-2", sellingPrice: 5.00),
        Product(type: .Gears, title: "Piston Punisher", subtitle: "Gears Monster", price: "$5", productImage: "gears-3", productId: "gears-3", sellingPrice: 5.00),
        Product(type: .Gears, title: "Gearhead Ghoul", subtitle: "Gears Monster", price: "$5", productImage: "gears-4", productId: "gears-4", sellingPrice: 5.00),
        Product(type: .Gold, title: "Golden Goliath", subtitle: "Gold Monster", price: "$5", productImage: "gold-1", productId: "gold-1", sellingPrice: 5.00),
        Product(type: .Gold, title: "Majestic Monstrosity", subtitle: "Gold Monster", price: "$5", productImage: "gold-2", productId: "gold-2", sellingPrice: 5.00),
        Product(type: .Gold, title: "Radiant Rascal", subtitle: "Gold Monster", price: "5", productImage: "gold-3", productId: "gold-3", sellingPrice: 5.00),
        Product(type: .Gold, title: "Golden Gladiator", subtitle: "Gold Monster", price: "$5", productImage: "gold-4", productId: "gold-4", sellingPrice: 5.00),
        Product(type: .Green, title: "Emerald Enigma", subtitle: "Green Monster", price: "$5", productImage: "green-1", productId: "green-1", sellingPrice: 5.00),
        Product(type: .Green, title: "Green Gargoyle", subtitle: "Green Monster", price: "$5", productImage: "green-2", productId: "green-2", sellingPrice: 5.00),
        Product(type: .Green, title: "Grassy Goliath", subtitle: "Green Monster", price: "$5", productImage: "green-3", productId: "green-3", sellingPrice: 5.00),
        Product(type: .Green, title: "Olive Ogre", subtitle: "Green Monster", price: "$5", productImage: "green-4", productId: "green-4", sellingPrice: 5.00),
        Product(type: .Pink, title: "Pink Panthera", subtitle: "Pink Monster", price: "$5", productImage: "pink-1", productId: "pink-1", sellingPrice: 5.00),
        Product(type: .Pink, title: "Pink Poltergeist", subtitle: "Pink Monster", price: "$5", productImage: "pink-2", productId: "pink-2", sellingPrice: 5.00),
        Product(type: .Pink, title: "Pink Poison", subtitle: "Pink Monster", price: "$5", productImage: "pink-3", productId: "pink-3", sellingPrice: 5.00),
        Product(type: .Pink, title: "Pink Puncher", subtitle: "Pink Monster", price: "$5", productImage: "pink-4", productId: "pink-4", sellingPrice: 5.00),
        Product(type: .Purple, title: "Grim Grape", subtitle: "Purple Monster", price: "$5", productImage: "purple-1", productId: "purple-1", sellingPrice: 5.00),
        Product(type: .Purple, title: "Violet Vindicator", subtitle: "Purple Monster", price: "$5", productImage: "purple-2", productId: "purple-2", sellingPrice: 5.00),
        Product(type: .Purple, title: "Lavender Lurker", subtitle: "Purple Monster", price: "$5", productImage: "purple-3", productId: "purple-3", sellingPrice: 5.00),
        Product(type: .Purple, title: "Purple Poltergeist", subtitle: "Purple Monster", price: "$5", productImage: "purple-4", productId: "purple-4", sellingPrice: 5.00),
        Product(type: .Rainbow, title: "Rainbow Rampager", subtitle: "Rainbow Monster", price: "$5", productImage: "rainbow-1", productId: "rainbow-1", sellingPrice: 5.00),
        Product(type: .Rainbow, title: "Technicolor Terror", subtitle: "Rainbow Monster", price: "$5", productImage: "rainbow-2", productId: "rainbow-2", sellingPrice: 5.00),
        Product(type: .Rainbow, title: "Colorful Conqueror", subtitle: "Rainbow Monster", price: "$5", productImage: "rainbow-3", productId: "rainbow-3", sellingPrice: 5.00),
        Product(type: .Rainbow, title: "Multicolored Menace", subtitle: "Rainbow Monster", price: "$5", productImage: "rainbow-4", productId: "rainbow-4", sellingPrice: 5.00),
        Product(type: .Red, title: "Fireball Fury", subtitle: "Red Monster", price: "$5", productImage: "red-1", productId: "red-1", sellingPrice: 5.00),
        Product(type: .Red, title: "Red Rascal", subtitle: "Red Monster", price: "$5", productImage: "red-2", productId: "red-2", sellingPrice: 5.00),
        Product(type: .Red, title: "Crimson Crusher", subtitle: "Red Monster", price: "$5", productImage: "red-3", productId: "red-3", sellingPrice: 5.00),
        Product(type: .Red, title: "Vermilion Vandal", subtitle: "Red Monster", price: "$5", productImage: "red-4", productId: "red-4", sellingPrice: 5.00),
        Product(type: .Royal, title: "Kingly Killer", subtitle: "Royal Monster", price: "$5", productImage: "royal-1", productId: "royal-1", sellingPrice: 5.00),
        Product(type: .Royal, title: "Noble Nightmare", subtitle: "Royal Monster", price: "$5", productImage: "royal-2", productId: "royal-2", sellingPrice: 5.00),
        Product(type: .Royal, title: "Crowned Conqueror", subtitle: "Royal Monster", price: "$5", productImage: "royal-3", productId: "royal-3", sellingPrice: 5.00),
        Product(type: .Royal, title: "Regal Ravager", subtitle: "Royal Monster", price: "$5", productImage: "royal-4", productId: "royal-4", sellingPrice: 5.00),
        Product(type: .Scales, title: "Reptilian Rampage", subtitle: "Scales Monster", price: "$5", productImage: "scales-1", productId: "scales-1", sellingPrice: 5.00),
        Product(type: .Scales, title: "Serpentine Savage", subtitle: "Scales Monster", price: "$5", productImage: "scales-2", productId: "scales-2", sellingPrice: 5.00),
        Product(type: .Scales, title: "Crocodile Crusader", subtitle: "Scales Monster", price: "$5", productImage: "scales-3", productId: "scales-3", sellingPrice: 5.00),
        Product(type: .Scales, title: "Gecko Gladiator", subtitle: "Scales Monster", price: "$5", productImage: "scales-4", productId: "scales-4", sellingPrice: 5.00),
        Product(type: .Teal, title: "Teal Terror", subtitle: "Teal Monster", price: "$5", productImage: "teal-1", productId: "teal-1", sellingPrice: 5.00),
        Product(type: .Teal, title: "Turquoise Tyrant", subtitle: "Teal Monster", price: "$5", productImage: "teal-2", productId: "teal-2", sellingPrice: 5.00),
        Product(type: .Teal, title: "Aquamarine Assassin", subtitle: "Teal Monster", price: "$5", productImage: "teal-3", productId: "teal-3", sellingPrice: 5.00),
        Product(type: .Teal, title: "Cyan Crusher", subtitle: "Teal Monster", price: "$5", productImage: "teal-4", productId: "teal-4", sellingPrice: 5.00),
        Product(type: .Tiger, title: "Striped Stalker", subtitle: "Tiger Monster", price: "$5", productImage: "tiger-1", productId: "tiger-1", sellingPrice: 5.00),
        Product(type: .Tiger, title: "Wildcat Warrior", subtitle: "Tiger Monster", price: "$5", productImage: "tiger-2", productId: "tiger-2", sellingPrice: 5.00),
        Product(type: .Tiger, title: "Roaring Rampager", subtitle: "Tiger Monster", price: "$5", productImage: "tiger-3", productId: "tiger-3", sellingPrice: 5.00),
        Product(type: .Tiger, title: "Fierce Feline", subtitle: "Tiger Monster", price: "$5", productImage: "tiger-4", productId: "tiger-4", sellingPrice: 5.00),
        Product(type: .Yellow, title: "Lemon Lurker", subtitle: "Yellow Monster", price: "$5", productImage: "yellow-1", productId: "yellow-1", sellingPrice: 5.00),
        Product(type: .Yellow, title: "Yellow Yowler", subtitle: "Yellow Monster", price: "$5", productImage: "yellow-2", productId: "yellow-2", sellingPrice: 5.00),
        Product(type: .Yellow, title: "Saffron Slayer", subtitle: "Yellow Monster", price: "$5", productImage: "yellow-3", productId: "yellow-3", sellingPrice: 5.00),
        Product(type: .Yellow, title: "Dandelion Destroyer", subtitle: "Yellow Monster", price: "$5", productImage: "yellow-4", productId: "yellow-4", sellingPrice: 5.00),
    ]
    
    // Filtered Products...
    @Published var filteredProducts: [Product] = []
    
    // More products on the type..
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.type == self.productType
                }
            // Limiting result...
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
