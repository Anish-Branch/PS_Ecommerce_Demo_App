//
//  ProductDetailView.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 01/12/21.
//

import SwiftUI
import BranchSDK

struct ProductDetailView: View {
    var product: Product
    
    // For Matched Geometry Effect...
    var animation: Namespace.ID
    
    // Branch.io - Create instance of the Branch Universal Object and Branch Link Properties
    internal var buo = BranchUniversalObject()
    internal var lp = BranchLinkProperties()
    
    // Shared Data Model...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        VStack{
            
            // Title Bar and Product Image...
            VStack{
                
                // Title Bar...
                HStack{
                    
                    Button {
                        // Closing View...
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }


                }
                .padding()
                
                // Product Image...
                // Adding Matched Geometry Effect...
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            // product Details...
            ScrollView(.vertical, showsIndicators: false) {
                
                // Product Data...
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Get Apple TV+ free for a year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, £4.99/month after free trial.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        
                        // Since we need image at right...
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.custom(customFont, size: 15).bold())
                        .foregroundColor(Color("Purple"))
                    }

                    HStack{
                        
                        Text("Total")
                            .font(.custom(customFont, size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.vertical,20)
                    
                    // Add button...
                    Button {
                        addToCart()
                        branchEventAddToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add") to basket")
                            .font(.custom(customFont, size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                            
                                Color("Purple")
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }

                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,25)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                // Corner Radius for only top side....
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .background(Color("HomeBG").ignoresSafeArea())
    }
    
    func isLiked()->Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()->Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.likedProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            // Remove from liked....
            sharedData.cartProducts.remove(at: index)
        }
        else{
            // add to liked
            sharedData.cartProducts.append(product)
        }
    }
    // Branch.io - Track Event - Add To Cart
    func branchEventAddToCart(){
        // Create a BranchUniversalObject with your content data:
        let branchUniversalObject = BranchUniversalObject.init()

        // ...add data to the branchUniversalObject as needed...
        branchUniversalObject.title               = product.title

        branchUniversalObject.contentMetadata.contentSchema     = .commerceProduct
        branchUniversalObject.contentMetadata.quantity          = 1
        branchUniversalObject.contentMetadata.price             = product.sellingPrice
        branchUniversalObject.contentMetadata.currency          = .USD
        branchUniversalObject.contentMetadata.productName       = product.title
        branchUniversalObject.contentMetadata.productVariant    = product.subtitle

        // Create a BranchEvent:
        let event = BranchEvent.standardEvent(.addToCart)

        // Add the BranchUniversalObject with the content (do not add an empty branchUniversalObject):
        event.contentItems     = [ branchUniversalObject ]

        // Add relevant event data:
        event.alias            = "my custom alias anish"
        event.currency         = .USD
        event.eventDescription = "Event_description anish"
        event.logEvent() // Log the event.
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample Product for Building Preview....
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        
        MainPage()
    }
}
