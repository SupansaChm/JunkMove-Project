//
//  SellerListView.swift
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

struct SellerListView: View {
   
    @Binding var showSellerListView : Bool
    @ObservedObject var sellerList = SellerListModel()
    @State var showTabView = false
    @State var showSellerChatView = false
    
    
    var body: some View {
        
            
            ZStack{
               
                VStack{
                    
                    ZStack{
                       
                        Image("img_back")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width:20, height: 20)
                         .padding(.top,-100)
                         .padding(.trailing,300)
                    
                    }     .onTapGesture {
                        
                        self.showSellerChatView.toggle()
                        
                        }
                        
                        .sheet(isPresented: $showSellerChatView) {

                            SellerChatView(showSellerChatView: self.$showSellerChatView)

                        }
                    
                    if sellerList.sellerInfo.pic != "" {

                            WebImage(url: URL(string: sellerList.sellerInfo.pic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.all,3)
                                .overlay(Circle().stroke(Color("blue_deep"),lineWidth: 1.5))
                                .padding()
                        
                    }
                    
                    Text(sellerList.sellerInfo.name + " " + sellerList.sellerInfo.last_name)
                        .font(.custom("Prompt-SemiBold", size: 18, relativeTo: .body))
                        .foregroundColor(Color.black)
                   
                    Text("ที่อยู่ " + sellerList.sellerInfo.address)
                        .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.black)
                  
                    HStack{
                        
                        Text("เบอร์โทรศัพท์")
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                        
                        Text("0891108797")
                            .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.black)
                    }
                  
                
                
        }.background(Color.white).ignoresSafeArea(.all)
        
        
    }
}
}
