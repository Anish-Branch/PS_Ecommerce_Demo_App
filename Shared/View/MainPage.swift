//
//  MainPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 27/11/21.
//

import SwiftUI
import BranchSDK

struct MainPage: View {
    
    // Current Tab...
    @State var currentTab: Tab = .Home
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    // Animation Namespace...
    @Namespace var animation
    
    // Hiding Tab Bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        VStack(spacing: 0){
            
            // Tab View...
            TabView(selection: $currentTab) {
                
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
            }
            
            // Custom Tab Bar...
            HStack(spacing: 0){
                ForEach(Tab.allCases,id: \.self){tab in
                    
                    Button {
                        // updating tab...
                        currentTab = tab
                    } label: {
                     
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        // Applying little shadow at bg...
                            .background(
                            
                                Color("Purple")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                // blurring...
                                    .blur(radius: 5)
                                // Making little big...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                                
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Purple") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal,.top])
            .padding(.bottom,10)
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay(
        
            ZStack{
                // Detail Page...
                if let product = sharedData.detailProduct,sharedData.showDetailProduct{
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    // adding transitions...
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
            // Branch.io - Handle a deep link that contains a product ID, retrieving the corresponding product information from a data source, and updating the view's state to display the product details.
        ).onAppear{
            NotificationCenter.default.addObserver(forName: Notification.Name("HANDLEDEEPLINK"), object: nil, queue: nil) { notification in
                guard let userInfo = notification.userInfo as? Dictionary<String, Any> else {return}
               
                if let productIDURL = userInfo["product_id"] as? String {
                    let productID = productIDURL.replacingOccurrences(of: "https://www.branch.io/", with: "")
                    print("UserID = \(productID)")
                    let homeViewModel = HomeViewModel()
                   let filteredProducts =  homeViewModel.products.filter {$0.productId == productID}
                    print("filter product == \(filteredProducts)")
                    if filteredProducts.count != 0 {
                        sharedData.detailProduct = filteredProducts[0]
                        sharedData.showDetailProduct = true
                    }
                }
            }
        }
    }
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Making Case Iteratable...
// Tab Cases...
enum Tab: String,CaseIterable{
    
    // Raw Value must be image Name in asset..
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
