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

struct TruckListView: View {
   
    @Binding var showTruckListView : Bool
    @State var showTabView = false
    @ObservedObject var truckList = TruckListModel()
    @StateObject var settingsData = SettingViewModel()
    @StateObject var sellerRegisterData = SellerRegisterViewModel()
    @State var showListControlView = false
    @State var showTruckChatView = false
   
    
    var body: some View {
        
            
            ZStack{
               
                HStack{
                    
                    Image("img_back")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width:20,height: 20)
                     .padding(.bottom,570)
                     .padding(.trailing,280)
                     
                }  .onTapGesture {
                    
                    self.showTabView.toggle()
                    
                    }
                    
                    .fullScreenCover(isPresented: $showTabView) {

                        tabView(showTabView: self.$showTabView)

                    }
                
                VStack{
                    
                    if truckList.truckInfo.pic != "" {

                            WebImage(url: URL(string: truckList.truckInfo.pic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.all,3)
                                .overlay(Circle().stroke(Color("ocean_deep"),lineWidth: 1.5))
                                .padding()
                        
                    }
                    
                    Text(truckList.truckInfo.storeName)
                        .font(.custom("Prompt-SemiBold", size: 16, relativeTo: .body))
                        .foregroundColor(Color.black)
                  
                    HStack {
                        
                    Image("img_star")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 10, height: 10)
                    
                    Text("คะแนนร้าน " + truckList.truckInfo.truck_point)
                        .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.gray)
                    
                    Text("ระยะทาง " + truckList.truckInfo.truck_distance + " กิโลเมตร")
                        .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.gray)
                    
                    }.padding(.top,-10)
                    
                    Text("ใกล้ที่สุด")
                        .font(.custom("Prompt-SemiBold", size: 14, relativeTo: .body))
                        .foregroundColor(Color.green)
                    Divider()
                }
                .padding(.top,-300)
                Spacer()
                
                
                
                VStack{
                    
                    Image("img_about")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:32, height: 32)
                        
                    
                    HStack(spacing:115){
                        
                        Text("รายละเอียด")
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                        
                        Text(truckList.truckInfo.moreDetail)
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.black)
                    }.padding(.all,7)
                    Divider()
                    
                    HStack(spacing:125){
                        
                        Text("เปิด-ปิด")
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                        
                        Text(truckList.truckInfo.timeOpen + " - " + truckList.truckInfo.timeClose)
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.black)
                    }.padding(.all,7)
                    Divider()
                    
                    HStack(spacing:115){
                        
                        Text("เบอร์โทรศัพท์")
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                        
                        Text("0891108797")
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.black)
                    }.padding(.all,7)
                    Divider()
                    
                    HStack(spacing:115){
                        
                        Text("ทะเบียนรถ")
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                        
                        Text(truckList.truckInfo.truckNumber)
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.black)
                    }.padding(.all,7)
                    Divider()
                    
                   
                }.padding(.top,150)
                
                
                
                    Button(action:{
                        
                        self.showTruckChatView.toggle()
                            
                        
                    }){
                        Image("img_chat")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:68, height: 68)
                            .padding(.top,600)
                    }.sheet(isPresented: $showTruckChatView) {
                        
                        truckChatView(showTruckChatView: self.$showTruckChatView)

                    }
                
                
        }.background(Color.white).ignoresSafeArea(.all)
        
        
    }
}

