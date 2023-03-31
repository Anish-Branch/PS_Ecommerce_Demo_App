//
//  testNavigationView.swift
//  EcommerceAppKit (iOS)
//
//  Created by Anish Somani on 28/03/2023.
//

import SwiftUI

struct testNavigationView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
           NavigationView {
               VStack {
                   Text("Welcome to my app!")
                       .font(.title)
                   
                   NavigationLink(
                       destination: MainPage(),
                       isActive: $isActive,
                       label: {
                           Text("Go to Detail View")
                               .font(.headline)
                               .foregroundColor(.white)
                               .padding()
                               .background(Color.blue)
                               .cornerRadius(10)
                       })
                       .padding(.top, 50)
                   
                   Spacer()
               }
               .navigationTitle("My App")
           }
       }
   }

struct testNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        testNavigationView()
    }
}
