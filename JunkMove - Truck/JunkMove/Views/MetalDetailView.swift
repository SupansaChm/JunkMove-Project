//
//  MetalDetailView.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/27/21.
//

import SwiftUI

struct MetalDetailView: View {
    
    @Binding var showMetalDetailView : Bool
    
    var body: some View {
        
        
        Text("ราคารับซื้อโลหะ บาท/กก.")
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
             
                Text("กระป๋อง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-35)
                
                Text("1.00")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,115)
            }
            
            HStack {
             
                Text("เหล็กบาง/เมทัลชีท")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                Text("5.46")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,80)
                
            }
            
            HStack {
             
                Text("เหล็กหนา")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-30)
                Text("6.23")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 100)
                    .padding(.leading,110)
                
            }
            
            HStack {
             
                Text("ทองเหลือง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-23)
                Text("66.50")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,125)
                
            }
            
            HStack {
             
                Text("ทองแดง")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-30)
                Text("104.30")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,128)
                
            }
            
            HStack {
             
                Text("อลูมิเนียม")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 150)
                    .padding(.leading,-30)
                Text("24.50")
                    .font(.custom("Prompt-light", size: 16, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .frame(width: 50)
                    .padding(.leading,128)
                
            }
        }
        Text("อ้างอิงราคารับซื้อจาก : https://www.junkbank.co/#/")
            .font(.custom("Prompt-light", size: 12, relativeTo: .body))
            .foregroundColor(Color.gray)
            .padding(.bottom,30)
        
    }
}

