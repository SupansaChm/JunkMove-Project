//
//  TruckListView.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/28/21.
//


import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage
import Foundation
import SDWebImageSwiftUI

struct TableView: View {
   
    @Binding var showTableView : Bool
    @State var showTabView = false
    @StateObject var settingsData = SettingViewModel()
    @StateObject var RegisterData = RegisterViewModel()
   
    
    var body: some View {
        
            ZStack{
               
                VStack{
                    
                    
                    HStack {
                    
                    Text("ตารางการเข้าไปรับซื้อของฉัน")
                        .font(.custom("Prompt-SemiBold", size: 20, relativeTo: .body))
                        .foregroundColor(Color.black)
                        
                    }.padding(.top,10)
                    
                    Image("img_dt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 220)
                    
                    Divider()
                   
                }.padding(.top,-300)
        
                VStack{
                    
                    Image("img_cb")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 330)
                }.padding(.bottom,-70)
                .padding(.leading,20)
                
        }
    }
}

