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

struct CommentView: View {
   
    @Binding var showCommentView : Bool
    @State var showTabView = false
    @StateObject var settingsData = SettingViewModel()
    @StateObject var RegisterData = RegisterViewModel()
   
    
    var body: some View {
        
            ZStack{
               
                VStack{
                    
                    if settingsData.userInfo.pic != "" {

                            WebImage(url: URL(string: settingsData.userInfo.pic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.all,3)
                                .overlay(Circle().stroke(Color("ocean_deep"),lineWidth: 1.5))
                                .padding()
                        
                    }
                    
                    HStack {
                    
                    Text(settingsData.userInfo.storeName)
                        .font(.custom("Prompt-SemiBold", size: 20, relativeTo: .body))
                        .foregroundColor(Color.black)
                    
                    Text("(รถรับซื้อ)")
                        .font(.custom("Prompt-Light", size: 18, relativeTo: .body))
                        .foregroundColor(Color.gray)
                    }
                    
                    HStack {
                        
                    Image("img_star")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 10, height: 10)
                    
                    Text("คะแนน " + settingsData.userInfo.truck_point + "/5")
                        .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.gray)
                    
                    }.padding(.top,-10)
                    
                    Divider()
                   
                }
                .padding(.top,-320)
        
                VStack{
                    
                    Image("img_review")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 320)
                }.padding(.bottom,-110)
                
        }
    }
}

