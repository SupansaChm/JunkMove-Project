//
//  GlassDetailView.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/27/21.
//

import SwiftUI

struct GlassDetailView: View {
   
    @Binding var showGlassDetailView : Bool
    
    var body: some View {
        
        
        Text("ราคารับซื้อขวดแก้ว บาท/กก.")
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
             
                Text("ขวดแก้วขาว")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-25)
                
                Text("1.68")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,105)
            }
            
            HStack {
             
                Text("ขวดแก้วชา")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-30)
                Text("1.58")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,110)
                
            }
            
            HStack {
             
                Text("ขวดแก้วเขียว")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-23)
                Text("1.40")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,102)
                
            }
            
            HStack {
             
                Text("ขวดเบียร์ลีโอ (กล่อง)")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,3)
                Text("8.05/กล่อง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 80)
                    .padding(.leading,100)
                
            }
            
            HStack {
             
                Text("ขวดเบียร์ช้าง (กล่อง)")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,4)
                Text("8.75/กล่อง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 80)
                    .padding(.leading,100)
                
            }
            
            HStack {
             
                Text("ขวดเหล้าขาว (กล่อง)")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,3)
                Text("7.70/กล่อง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 80)
                    .padding(.leading,100)
                
            }
            
            HStack {
             
                Text("ขวดแก้วรวม")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-25)
                Text("1.19")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,130)
                
            }
        }
        Text("อ้างอิงราคารับซื้อจาก : https://www.junkbank.co/#/")
            .font(.custom("Prompt-light", size: 12, relativeTo: .body))
            .foregroundColor(Color.gray)
            .padding(.bottom,30)
        
    }
}

