//
//  PlassticDetailView.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/27/21.
//

import SwiftUI

struct PlassticDetailView: View {
   
    @Binding var showPlassticDetailView : Bool
    
    var body: some View {
        
        
        Text("ราคารับซื้อพลาสติก บาท/กก.")
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
             
                Text("ขวดใสมีฉลาก")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-20)
                
                Text("5.60")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,100)
            }
            
            HStack {
             
                Text("ขวดใสไม่มีฉลาก")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-15)
                Text("7.00")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,95)
                
            }
            
            HStack {
             
                Text("ขวดสไปร์ทไม่มีฉลาก")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,1)
                Text("4.55")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,80)
                
            }
            
            HStack {
             
                Text("ท่อสีฟ้า/เหลือง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-15)
                Text("4.20")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,120)
                
            }
            
            HStack {
             
                Text("พลาสติกรวม")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-20)
                Text("1.00")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,125)
                
            }
            
            HStack {
             
                Text("สายยางใส")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-30)
                Text("4.20")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,135)
                
            }
        }
        Text("อ้างอิงราคารับซื้อจาก : https://www.junkbank.co/#/")
            .font(.custom("Prompt-light", size: 12, relativeTo: .body))
            .foregroundColor(Color.gray)
            .padding(.bottom,30)
        
    }
}

