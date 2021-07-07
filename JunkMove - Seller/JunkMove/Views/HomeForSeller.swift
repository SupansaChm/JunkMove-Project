//
//  Home.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/16/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage


struct HomeForSeller: View {
    
    @Binding var showHomeForSeller : Bool
    @State var showTabView = false

    var body: some View {
        
        VStack{
        
               
            tabView(showTabView: $showTabView)
            
        }
    }
}


