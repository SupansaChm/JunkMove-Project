//
//  ExplanPage.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/16/21.
//

import SwiftUI

struct ExplanPage: View {
   
    var body: some View {
        
        HStack{
            
        Image("circle")
            .resizable()
            .frame(width: 120.0, height: 120.0)
            
        }.padding(.trailing, 254)
        .padding(.top,-27)
        
        VStack{
       
            Image("img_explan")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200.0, height: 200.0)
                .padding(.top,55)
            
            Text("เปลี่ยนขยะให้กลายเป็นเงิน")
                .font(.custom("Prompt-SemiBold", size: 20))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
                .padding(.top,-35)
            
            VStack {
                
            Text("คุณสามารถเดินทางไปยังร้านรับซื้อขยะรีไซเคิล")
                .font(.custom("Prompt-Light", size: 15, relativeTo: .body))
                .foregroundColor(.black)
                .padding()
            Text("ที่แอปพลิเคชันแนะนำ หรือใช้บริการรถรับซื้อขยะ")
                .font(.custom("Prompt-Light", size: 15, relativeTo: .body))
                .foregroundColor(.black)
                .padding(.top,-23)
            Text("รีไซเคิลก็ได้")
                .font(.custom("Prompt-Light", size: 15, relativeTo: .body))
                .foregroundColor(.black)
                .padding(.top,0)
                .frame(width: 282, alignment: .leading)
            }
            
            
        } ;Spacer()

    }
}
