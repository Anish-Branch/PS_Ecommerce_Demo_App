//
//  OrderConfirmationPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by Anish Somani on 27/03/2023.
//

import SwiftUI

struct OrderConfirmationPage: View {
    
    @State var isOn = false // 1
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    
    var body: some View {

        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("Order Confirmation")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                    
                    VStack(spacing: 15){
                        
                        Image("green_check_mark")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom,-30)
                        
                        Text("Order Confirmed")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        HStack(alignment: .top, spacing: 10) {
                            

                            Text("Your dummy order has been confirmed\n\n'Start Over' to order more Monsters & see Branch deep linking in action!")
                                .font(.custom(customFont, size: 15))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal,.bottom])
                    .background(
                    
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top,40)
                    
                    Button {
                        loginData.Logout()
                    } label: {
                        Text("Start Over")
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
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }
    
    // Avoiding new Structs...
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)->some View{
        
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
            
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
}


struct OrderConfirmationPage_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationPage()
    }
}
