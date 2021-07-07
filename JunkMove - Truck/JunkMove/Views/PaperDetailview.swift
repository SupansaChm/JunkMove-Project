//
//  PaperDetailView.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/27/21.
//

import SwiftUI

struct PaperDetailView: View {
    
    @Binding var showPaperDetailView : Bool
    var body: some View {
        
        
        Text("ราคารับซื้อกระดาษ บาท/กก.")
            .font(.custom("Prompt-SemiBold", size:20, relativeTo: .body))
            .foregroundColor(Color.black)
            .padding(.top,30)
        
        
        List{
            
            HStack {
             
                Text("ชื่อ")
                    .font(.custom("Prompt-light", size: 12, relativeTo: .body))
                    .foregroundColor(Color.gray)
                
                
                Text("ราคา บาท / กก.")
                    .font(.custom("Prompt-light", size: 12, relativeTo: .body))
                    .foregroundColor(Color.gray)
                    .padding(.leading,235)
                
            }
            
            HStack {
             
                Text("กระดาษน้ำตาล")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-20)
                
                Text("3.29")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,100)
            }
            
            HStack {
             
                Text("กระดาษหนังสือพิมพ์")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                Text("1.40")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,80)
                
            }
            
            HStack {
             
                Text("กระดาษขาวดำ")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-20)
                Text("3.85")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,100)
                
            }
            
            HStack {
             
                Text("กระดาษรวม")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-27)
                Text("1.89")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,105)
                
            }
            
            HStack {
             
                Text("กระดาษหนังสือเล่ม งดแฟ้มแข็ง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                Text("1.40")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,102)
                
            }
        }
        Text("อ้างอิงราคารับซื้อจาก : https://www.junkbank.co/#/")
            .font(.custom("Prompt-light", size: 12, relativeTo: .body))
            .foregroundColor(Color.gray)
            .padding(.bottom,30)
        
    }
}

