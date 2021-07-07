//
//  ContentView.swift
//  JunkMove
//
//  Created by Supansa Ch on 1/18/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage


struct ContentView: View {
    
   
   
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var showOTPView = false
    @State var showHomeView = false
    @State var loading = false
    
    var body: some View {
     
        VStack{
            
            if status {
                
                HomeView(showHomeView: self.$showHomeView)
               
            }
            
            else {
                
                NavigationView {

                    OTPView(showOTPView: self.$showOTPView)
                }
            }
        }.onAppear{
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                
                self.status = status
            }
        }

                
    }
}
        














