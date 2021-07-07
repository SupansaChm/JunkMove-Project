//
//  HomeForTruck.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/30/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage


struct HomeView: View {
    
    @Binding var showHomeView : Bool
    @State var showTabView = false
    @State var showRegisterView = false
    @AppStorage("current_identity") var identity = false

    var body: some View {
        
            
        VStack{
            
            if identity {
                
                CustomTabView(showTabView: self.$showTabView)
               
            }
            
            else {
                
                NavigationView {

                    RegisterView(showRegisterView: self.$showRegisterView)
                }
            }
        }
  
    }
}
