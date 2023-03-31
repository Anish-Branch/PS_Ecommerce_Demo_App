//
//  LoginPageModel.swift
//  EcommerceAppKit (iOS)
//
//  Created by Balaji on 26/11/21.
//

import SwiftUI

struct User {
    let email: String
    let password: String
}

class UserDatabase {
    static var users = [
        User(email: "anish.somani@branch.io", password: "Proserve"),
        User(email: "gareth.evans@branch.io", password: "Proserve"),
        User(email: "oshpilev@branch.io", password: "Proserve")
    ]
    
    static func getUser(email: String) -> User? {
        return users.first(where: { $0.email == email })
    }
    
    static func addUser(email: String, password: String) {
        users.append(User(email: email, password: password))
    }
}

class LoginPageModel: ObservableObject {

    // Login Properties..
     @Published var email: String = ""
     @Published var password: String = ""
     @Published var showPassword: Bool = false
     
     // Register Properties
     @Published var registerUser: Bool = false
     @Published var re_Enter_Password: String = ""
     @Published var showReEnterPassword: Bool = false
     
     // Log Status...
     @AppStorage("log_Status") var log_Status: Bool = false
         
     // Login Call...
     func Login(){
     // Do Action Here...
         guard let user = UserDatabase.getUser(email: email) else {
             return
         }
     withAnimation{
         if user.password == password {
             log_Status = true
             print(log_Status)
         }
     }
     }
    
    func Logout(){
            log_Status = false
            print(log_Status)
        }
     
     func Register(){
     // Do Action Here...
         guard password == re_Enter_Password else {
             return
         }
     withAnimation{
         UserDatabase.addUser(email: email, password: password)
     log_Status = true
     }
     }
     
     func ForgotPassword(){
     // Do Action Here...
     }
     }
     
