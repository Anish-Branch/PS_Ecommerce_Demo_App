//
//  OnBoardingPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 26/11/21.
//

import SwiftUI

// To Use the custom font on all pages..
let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    // Showing Login Page...
    @State var showLoginPage: Bool = false
    var body: some View {
        
        VStack(alignment: .leading){
            
            GeometryReader { geometry in
                VStack {
                    Image("monster-store-logo-light-bkg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(geometry.size.width, geometry.size.height) * 0.8)
                    
                    
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            Button {
                withAnimation{
                    showLoginPage = true
                }
            } label: {
             
                Text("Get started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
            }
            .padding(.horizontal,30)
            // Adding Some Adjustments only for larger displays...
            .offset(y: getRect().height < 750 ? 20 : 0)
            
            Spacer()
        }
        .padding()
        .padding(.top,getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
            Color.white
        )
        .overlay(
        
            Group{
                if showLoginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

// Extending View to get Screen Bounds..
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
