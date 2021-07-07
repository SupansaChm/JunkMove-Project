//
//  ListControlView.swift
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

struct ListControlView: View {
    
    @Binding var showListControlView : Bool
    @State var showTruckListView = false
    @State var showShopListView = false
    @State var selectedMenu = "รถรับซื้อขยะรีไซเคิล"
    @StateObject var settingsData = SettingViewModel()
    @ObservedObject var truckList = TruckListModel()
    @StateObject var sellerRegisterData = SellerRegisterViewModel()
    @Namespace var animation
    @State var searchTruck = ""
    
//    var data : TruckModel
    
    var body: some View {
        
        TabView(selection: $selectedMenu){
            
            Color("light_grey")
                .tag("รถรับซื้อขยะรีไซเคิล")
            
            Color("light_grey")
                .tag("ร้านรับซื้อขยะรีไซเคิล")
            
        }
        
        HStack(spacing: 15){
            
            ForEach(menu,id: \.self){i in
                
                Button(action: {
                    
                    withAnimation(.spring()){
                        
                        selectedMenu = i
                    }
                    
                }){
                    VStack {
                        
                        Text(i)
                            .font(.custom("Prompt-Regular", size: 14, relativeTo: .body))
                            .foregroundColor(Color("blue_deep"))
                            
                        
                        Capsule()
                            .fill(self.selectedMenu == i ? Color("violet_light") : Color.clear)
                            .frame(width:100,height: 4)
                            .padding(.top,-40)
                           
                    }
                }
            }
        }.padding(.top,-210)
        
        
        VStack {
            
//                TextField("ค้นหา",text: $searchTruck)
//                    .frame(width: 320)
//                    .padding(.leading,10)
//                    .padding(.all,2)
//                    .background(Color(.white))
//                    .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                
               
            
            List{
            
                ForEach(self.truckList.datas){i in
    
                HStack {
                    
                    if truckList.truckInfo.pic != "" {

                            WebImage(url: URL(string: truckList.truckInfo.pic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding(.all,3)
                                .overlay(Circle().stroke(Color("ocean_deep"),lineWidth: 1.5))
                                .opacity(selectedMenu == "รถรับซื้อขยะรีไซเคิล" ? 1 : 0)
                        
                    }
            
                    VStack(alignment: .leading) {
                        
                        Text(i.storeName)
                            .font(.custom("Prompt-SemiBold", size: 14, relativeTo: .body))
                            .foregroundColor(Color.black)
                            
                        
                        HStack{
                            
                            Image("img_star")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 10, height: 10)
                            
                            Text(i.truck_point + " คะแนน")
                                .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                                .foregroundColor(Color.gray)
                            
                            Text(i.truck_distance + " กิโลเมตร")
                                .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                                .foregroundColor(Color.gray)
                                
                            }
                        
                        }
                    }
                    
                .onTapGesture {
                    
                    self.showTruckListView.toggle()
                    
                    }
                    
                .fullScreenCover(isPresented: $showTruckListView) {
                    
                    TruckListView(showTruckListView: self.$showTruckListView)
                    
                    }
                }
            }
            .opacity(selectedMenu == "รถรับซื้อขยะรีไซเคิล" ? 1 : 0)
        }
    }
}

var menu = ["รถรับซื้อขยะรีไซเคิล", "ร้านรับซื้อขยะรีไซเคิล"]

