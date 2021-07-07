//
//  price.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/26/21.
//

import SwiftUI

struct priceView: View {
    
    var priceData : RecModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6){
            
            ZStack{
                
                Color(UIColor.white)
                    .cornerRadius(15)
                    .padding(.all,10)
                    .padding(.vertical,250)
                
                VStack {
                    
                Text(priceData.waste_title)
                    .font(.custom("Prompt-SemiBold", size:20, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .padding()

                Text(priceData.waste_detail)
                    .font(.custom("Prompt-light", size: 12, relativeTo: .body))
                    .foregroundColor(Color("blue_deep"))
                    .padding()
                   
                }
            }
        }
    }
}

