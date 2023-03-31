//
//  EcommerceAppKitApp.swift
//  Shared
//
//  Created by Balaji on 26/11/21.
//

import SwiftUI
import BranchSDK
import AppTrackingTransparency
import AdSupport
import Firebase
import UserNotifications

@main
struct EcommerceAppKitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    Branch.getInstance().handleDeepLink(url)
                    //Branch.getInstance().handleDeepLink(withNewSession: URL(string: "https://ecommerce-demo.app.link/e41XMrABhxb"))
                
                })
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        FirebaseApp.configure()
        Messaging.messaging().delegate = self


        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        // Branch.io - Test your Branch Integration by calling validateSDKIntegration in your AppDelegate. Check your Xcode logs to make sure all the SDK Integration tests pass. Make sure to comment out or remove validateSDKIntegration in your production build.
        // Branch.getInstance().validateSDKIntegration()
        
        // Branch.io - Function used to enable Branch logging
        Branch.getInstance().enableLogging()
        
        // enable pasteboard check
        Branch.getInstance().checkPasteboardOnInstall()
        
        // Branch.io - Initialize Branch SDK
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
            // do stuff with deep link data (nav to page, display content, etc)
            print(params as? [String: AnyObject] ?? {})
            
            // Branch.io - Check for a "productId" parameter and navigate to the corresponding view
            if let productId = params?["$canonical_url"] as? String {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute:{
                    NotificationCenter.default.post(name: Notification.Name("HANDLEDEEPLINK"), object: nil, userInfo: ["product_id": productId])
                })
            }
            // Branch.getInstance().setRequestMetadataKey("{ANALYTICS_ID}", value: [...])
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            // Check for link_click_id
            if url.absoluteString.contains("link_click_id") {
                return Branch.getInstance().application(app, open: url, options: options)
            }
            return false
        }
    
    func handleBranch(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // Check for app.link or appropriate Branch custom domain
        if let webpageURL = userActivity.webpageURL, webpageURL.absoluteString.contains("app.link") {
            return Branch.getInstance().continue(userActivity)
        }
        return false
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
 
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
}
    
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
        print("dataDict: ", dataDict) // This token can be used for testing notifications on FCM
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }

    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.banner, .badge, .sound]])
  }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let pushPayload = response.notification.request.content.userInfo as? [String:Any]  {
            // Check to see if Branch Link is in payload
            if pushPayload["branch"] != nil {
                Branch.getInstance().handlePushNotification(response.notification.request.content.userInfo)
            } else {
                // Handle Legacy Deep Linking
                //let messageID = pushPayload[gcmMessageIDKey]
            }
        }
    }
}

