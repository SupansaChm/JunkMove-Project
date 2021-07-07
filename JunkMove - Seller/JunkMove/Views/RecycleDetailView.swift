//
//  RecycleDetail.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI

struct RecycleDetailView: View {
    
    @Binding var showRecycleDetailView : Bool
    @State var showGlassDetail = false
    @State var showMetalDetail = false
    @State var showPaperDetail = false
    @State var showPlassticDetail = false
    
    var body: some View {
      
        ZStack {
        
        VStack{
            
            Image("circle")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.bottom,550)
                .padding(.trailing,225)
                
            }
        
            Image("img_content")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.bottom,330)
              
            Text("วิธีการคัดแยกขยะรีไซเคิล")
                .font(.custom("Prompt-SemiBold", size: 18, relativeTo: .body))
                .foregroundColor(Color.black)
                .padding(.bottom,120)
            
            Text("ช่วยบอกวิธีการแยกขยะรีไซเคิลเพื่อให้สามารถขายได้ราคาที่สูงขึ้นเพียงแค่เลือก “ประเภท”จากเมนูด้านล่างนี้")
                .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                .foregroundColor(Color.black)
                .frame(width: 300)
                .padding()
            
            HStack {
                
                Button(action: {
                    
                    self.showGlassDetail.toggle()
                    
                }){
                    Text("ขวดแก้ว")
                        .font(.custom("Prompt-SemiBold", size: 14, relativeTo: .body))
                        .padding(.vertical,7)
                        .padding(.horizontal,20)
                        
                    
                }.foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("violet_light"), Color("violet_clear")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                .padding(.top,200)
                
               
            } .sheet(isPresented: $showGlassDetail) {
                
                GlassDetail(showGlassDetail: self.$showGlassDetail)

            }.padding(.leading,-100)
            
            
            HStack {
                
                Button(action: {
                    
                    self.showPlassticDetail.toggle()
                    
                }){
                    Text("พลาสติก")
                        .font(.custom("Prompt-SemiBold", size: 14, relativeTo: .body))
                        .padding(.vertical,7)
                        .padding(.horizontal,20)
                        
                    
                }.foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("violet_light"), Color("violet_clear")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                .padding(.top,200)
                
               
            } .sheet(isPresented: $showPlassticDetail) {
                
                PlassticDetail(showPlassticDetail: self.$showPlassticDetail)

            }.padding(.leading,110)
            
            
            
            HStack {
                
                Button(action: {
                    
                    self.showMetalDetail.toggle()
                    
                }){
                    Text("โลหะ")
                        .font(.custom("Prompt-SemiBold", size: 14, relativeTo: .body))
                        .padding(.vertical,7)
                        .padding(.horizontal,20)
                        .padding(.leading,12)
                        .padding(.trailing,12)
                        
                    
                }.foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("violet_light"), Color("violet_clear")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                .padding(.top,300)
                
               
            } .sheet(isPresented: $showMetalDetail) {
                
                MetalDetail(showMetalDetail: self.$showMetalDetail)

            }.padding(.leading,-100)
            
            
            HStack {
                
                Button(action: {
                    
                    self.showPaperDetail.toggle()
                    
                }){
                    Text("กระดาษ")
                        .font(.custom("Prompt-SemiBold", size: 14, relativeTo: .body))
                        .padding(.vertical,7)
                        .padding(.horizontal,20)
                        .padding(.leading,5)
                        .padding(.trailing,5)
                        
                    
                }.foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("violet_light"), Color("violet_clear")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                .padding(.top,300)
                
               
            } .sheet(isPresented: $showPaperDetail) {
                
                PaperDetail(PaperDetail: self.$showPaperDetail)

            }.padding(.leading,110)
            
        }
    }
}

struct GlassDetail : View {

    @Binding var showGlassDetail : Bool
    
    var body: some View {
        
       Image("Glass")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 300)
        
    }
}

struct PlassticDetail : View {

    @Binding var showPlassticDetail : Bool
    
    var body: some View {
        
        Image("Plasstic")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
    }
}

struct MetalDetail : View {

    @Binding var showMetalDetail : Bool
    
    var body: some View {
        
        Image("Metal")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
    }
}

struct PaperDetail : View {

    @Binding var PaperDetail : Bool
    
    var body: some View {
        
        Image("Paper")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
    }
}
