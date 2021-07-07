//
//  truckChatView.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage
import Foundation
import SDWebImageSwiftUI
import FirebaseDatabase
import MapKit

struct SellerChatView: View {
    
    @Binding var showSellerChatView : Bool
    @State var showTruckListView = false
    @ObservedObject var chatData = ChatModel()
    @ObservedObject var sellerList = SellerListModel()
    @ObservedObject var Location = LocationFetcher()
    let locationFetcher = LocationFetcher()
    var settingsData = SettingViewModel()
    let uid = Auth.auth().currentUser!.uid
    @State var showSellerListView = false
    @State private var showingAlert = false
    @State var showLocationView = false
    @State var showDirection = false
    
    let DataRecommend = ["ตอบรับการนัดหมาย","ผู้ซื้อมาถึงแล้ว","เรากำลังรีบเดินทางไป","ขอขอบคุณที่ใช้บริการ","กรุณารอสักครู่","ขออภัยในความล่าช้า"]
    
    
    var body: some View {
        
        
        VStack(spacing:0){
            
            HStack{
                
                
                HStack{
                    
                Text(sellerList.sellerInfo.name + " " + sellerList.sellerInfo.last_name)
                    .font(.custom("Prompt-SemiBold", size: 16, relativeTo: .body))
                    .foregroundColor(Color.white)
                    
                    
                }.onTapGesture {
                    
                    self.showSellerListView.toggle()

                    }

                .fullScreenCover(isPresented: $showSellerListView) {

                    SellerListView(showSellerListView: self.$showSellerListView)

                    }
                
                
                Button{
                    
                    self.locationFetcher.start()
                    showingAlert = true
                    
                } label: {
                    
                    Image(systemName: "location.fill.viewfinder")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                       
                        .clipShape(Circle())
                        .padding(.leading,150)
                }
                
                Button{
                    
                    self.showDirection.toggle()
                    
                    
                } label: {
                    
                    Image(systemName: "map.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                      
                
                }.onTapGesture {
                    
                    self.showDirection.toggle()

                    }.sheet(isPresented: $showDirection) {
                    
                        Direction(showDirection: self.$showDirection)
                    
                    }
                
                Spacer(minLength: 0)
                
            }.padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color("ocean_deep"))
            ScrollViewReader{reader in
                ScrollView{
                    VStack(spacing:15){
                        ForEach(chatData.msg){msg in
                            ChatRow(chatData: msg, text: msg.text)
                        }
                    }
                    .padding(.vertical)
                }
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 10){
                    ForEach(DataRecommend, id: \.self){item in
                       
                        Button{
                        
                            let time = Date()
                            let formatter1 = DateFormatter()
                            formatter1.dateFormat = "HH:mm"
                            Firestore.firestore().collection("Messages").document(sellerList.sellerInfo.name + uid).collection("chat").addDocument(data: [
                                "profile": "",
                                "senderDisplayName" : settingsData.stName,
                                "text" : item,
                                "timeStamp" : formatter1.string(from: time)
                            ]) { err in
                                if let err = err {
                                    print("Error adding document: \(err)")
                                } else {
                                    print("Document added with ")
                                }
                            }
                            
                        } label: {
                            Text(item)
                                .font(.custom("Prompt-Medium", size: 16, relativeTo: .caption))
                                .foregroundColor(Color("blue_deep"))
                                .frame(width: 160, height: 40)
                                .background(Color("light_grey"))
                        }.cornerRadius(10)
                    }
                }
            }.animation(.default)
            .padding()
            
            HStack(spacing:15){
                
                TextField("พิมพ์ข้อความ", text: $chatData.txt)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color("light_grey"))
                    .clipShape(Capsule())
                
                if chatData.txt != "" {
                    
                    Button(action: chatData.writeMsg, label: {
                        
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color("ocean_deep"))
                            .clipShape(Circle())
                    })
                }
            }
            .animation(.default)
            .padding()
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .alert(isPresented: $showingAlert) {
            
            let primaryButton = Alert.Button.default(Text("ตกลง")) {
                if let location = self.locationFetcher.lastKnownLocation {
                    print("ที่อยู่ของคุณคือ \(location)")
                    
                    let db = Firestore.firestore()
                    db.collection("TruckUser").document(Auth.auth().currentUser!.uid).updateData([
                        
                        "latitude" : location.latitude,
                        "longitude" : location.longitude
                        
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
            
            return Alert(title: Text("ส่งตำแหน่งที่ตั้ง"), message: Text("ยืนยันการส่งตำแหน่งที่ตั้งไปให้ลูกค้าหรือไม่?"),primaryButton: primaryButton, secondaryButton: .default(Text("ยกเลิก")))
        }
        .onAppear {
            print("ContentView appeared!")
            self.chatData.readAllMsgs()
        }
    }
    
}





