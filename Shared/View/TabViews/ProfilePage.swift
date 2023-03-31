//
//  ProfilePage.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 30/11/21.
//

import SwiftUI
import BranchSDK
import UserNotifications

struct ProfilePage: View {
    @State var isOn = false // 1
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                    
                    VStack(spacing: 15){
                        
                        Image("Profile_Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom,-30)
                        
                        Text("Deep Link Monster")
                            .font(.custom(customFont, size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: Palo Alto\nCA 94306\nUnited States")
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
                        Text("Logout")
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
                    
                    Button("Generate QR Code") {
                        
                        let qrCode = BranchQRCode()
                        qrCode.codeColor = UIColor.white
                        qrCode.backgroundColor = UIColor.blue
                        qrCode.centerLogo = "https://cdn.branch.io/branch-assets/1598575682753-og_image.png"
                        qrCode.width = 1024
                        qrCode.margin = 1
                        qrCode.imageFormat = .JPEG

                        let buo = BranchUniversalObject()
                        let lp = BranchLinkProperties()

                        qrCode.getAsImage(buo, linkProperties: lp) { qrCodeImage, error in
                            //Do something with your QR code here...
                        }

                        //Or display the QR code directly in a share sheet
                        qrCode.showShareSheetWithQRCode(from: UIApplication.shared.windows.first?.rootViewController, anchor: nil, universalObject: buo, linkProperties: lp) { error in
                            //Showing a share sheet with the QR code
                        }
                        }
                    
                    Button("Schedule Local Push Notification") {
                        let content = UNMutableNotificationContent()
                        content.title = "Branch Monster Factory"
                        content.subtitle = "Check out this Monster"
                        content.sound = UNNotificationSound.default
                        content.userInfo = ["branch" : "https://ecommerce-demo.app.link/e41XMrABhxb"]
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                    }
                    
                                    
                    Toggle(isOn: $isOn, label: {
                             Label("Disable User Tracking", systemImage: "hand.raised")
                         })
                             .toggleStyle(SwitchToggleStyle())
                             .foregroundColor(.black)
                             .padding()
                             .onChange(of: isOn) { newValue in
                                 didTapToggleUserTracking()
                                 print("Toggle value changed to \(newValue)")
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

func didTapToggleUserTracking() {
    // Branch.io - Disable Tracking -> Deinitializes Branch Session
    switch Branch.trackingDisabled() {
    case false:
        Branch.setTrackingDisabled(true)
        print("Tracking Disabled")
    case true:
        Branch.setTrackingDisabled(false)
        print("Tracking Enabled")
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
