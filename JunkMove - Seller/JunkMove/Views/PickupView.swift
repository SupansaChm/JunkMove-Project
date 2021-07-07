//
//  PickupView.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI

struct PickupView: View {
    
    @Binding var showPickupView : Bool
   
    var body: some View {
       
        
        ZStack{
            
            VStack{
                
                Image("circle")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom,550)
                    .padding(.trailing,225)
                    
                }
            
            Text("การขายขยะรีไซเคิล")
                .font(.custom("Prompt-SemiBold", size: 18, relativeTo: .body))
                .foregroundColor(Color.black)
                .padding(.top,-280)
            
                Image("img_pickup")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top,-280)
                   
               Divider()
                .padding(.top,-90)
            
             Image("img_btnPickup")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding(.top,-120)
            
            Image("img_table")
               .resizable().aspectRatio(contentMode: .fit)
               .frame(width: 300, height: 300)
                .padding(.top,200)
                
            
        }
    }
}


