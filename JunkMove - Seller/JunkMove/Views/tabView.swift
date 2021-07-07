//
//  sellerTabView.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

struct tabView: View {
    
    @Binding var showTabView : Bool
    @StateObject var settingsData = SettingViewModel()
    @StateObject var sellerRegisterData = SellerRegisterViewModel()
    @State var showOTPView = false
    @State var showPaperDetailView = false
    @State var showListControlView = false
    @State var showMetalDetailView = false
    @State var showRecycleDetailView = false
    @State var showPlassticDetailView = false
    @State var showGlassDetailView = false
    @State var showPickupView = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var selectedtab = "user"
    
    init(showTabView: Binding<Bool>) {
        
        self._showTabView = showTabView
        UITabBar.appearance().isHidden = true
    }
    
    @State var xAxis : CGFloat = 0
    @Namespace var animation
    
    var body: some View {
      
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            TabView(selection: $selectedtab){
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("user")
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("chart")
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("recycle")
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("content")
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("pickup")
                
            }
            
            
            HStack(spacing: 0){
                
                ForEach(tabs,id: \.self){image in
                    
                    GeometryReader { reader in
                        Button(action: {
                            
                            withAnimation(.spring()){
                                selectedtab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                            
                        }, label: {
                            
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedtab == image ? getColor(image: image) : Color.gray)
                                .padding(selectedtab == image ? 15 : 0)
                                .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedtab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedtab == image ? -50 : 0 )
                    })
                        .onAppear(perform: {
                            
                            if image == tabs.first {
                                
                                xAxis = reader.frame(in: .global).minX
                            }
                        })
                }
                    .frame(width: 25, height: 30)
                    
                    if image != tabs.last{Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal,30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis)) .cornerRadius(12))
            .padding(.horizontal)
            //Buttom edge.....
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.bottom,40)
            
            
            
            
            ZStack {
               
                
                if settingsData.userInfo.pic != "" {

                        WebImage(url: URL(string: settingsData.userInfo.pic)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                                .padding(.all,5)
                            .overlay(Circle().stroke(Color("blue_deep"),lineWidth: 1))
                            .padding(.bottom,400)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                }
                
                        Text(settingsData.userInfo.name + " " + settingsData.userInfo.last_name)
                            .font(.custom("Prompt-SemiBold", size:20, relativeTo: .body))
                            .foregroundColor(Color("blue_deep"))
                            .padding(.bottom,220)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Image("circle")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.bottom,550)
                            .padding(.trailing,225)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Text("ชื่อ  ")
                            .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                            .padding(.bottom,100)
                            .padding(.trailing,250)
                            .opacity(selectedtab == "user" ? 1 : 0)
                        
                        Text(settingsData.userInfo.name)
                            .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                            .foregroundColor(Color("blue_deep"))
                            .padding(.bottom,100)
                            .padding(.leading,100)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Divider()
                            .frame(width:320)
                            .padding(.bottom,60)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Text("นามสกุล  ")
                            .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                            .padding(.bottom,10)
                            .padding(.trailing,220)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Text(settingsData.userInfo.last_name)
                            .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                            .foregroundColor(Color("blue_deep"))
                            .padding(.bottom,10)
                            .padding(.leading,100)
                            .opacity(selectedtab == "user" ? 1 : 0)
                
                        Divider()
                            .frame(width:320)
                            .padding(.top,30)
                            .opacity(selectedtab == "user" ? 1 : 0)
                
                        Button(action:  {

                            try! Auth.auth().signOut()

                            UserDefaults.standard.setValue(false, forKey: "status")

                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            
                            self.showOTPView.toggle()

                        }) {

                            Text("ออกจากระบบ")
                                .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                                .frame(width: 270)
                                .padding(.vertical,12)
                                .padding(.horizontal,32)
                        }.foregroundColor(.red)
                        .padding(.top,420)
                        .opacity(selectedtab == "user" ? 1 : 0)
                
            } .fullScreenCover(isPresented: $showOTPView) {
                OtpView(showOTPView: self.$showOTPView)
                
            }
            
            ZStack {
                
                    Text("เบอร์โทรศัพท์  ")
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.gray)
                        .padding(.bottom,300)
                        .padding(.trailing,190)
                        .opacity(selectedtab == "user" ? 1 : 0)
            
                Text(settingsData.userInfo.phoneNumber)
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color("blue_deep"))
                        .padding(.bottom,300)
                        .padding(.leading,100)
                        .opacity(selectedtab == "user" ? 1 : 0)
        
                    Divider()
                        .frame(width:320)
                        .padding(.bottom,260)
                        .opacity(selectedtab == "user" ? 1 : 0)
                
                
                    Text("ที่อยู่  ")
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.gray)
                        .padding(.bottom,210)
                        .padding(.trailing,240)
                        .opacity(selectedtab == "user" ? 1 : 0)
            
                    Text(settingsData.userInfo.address)
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color("blue_deep"))
                        .padding(.bottom,210)
                        .padding(.leading,90)
                        .opacity(selectedtab == "user" ? 1 : 0)
        
                    Divider()
                        .frame(width:320)
                        .padding(.bottom,150)
                        .opacity(selectedtab == "user" ? 1 : 0)
            }
            
            Button(action:  {
                    

            }) {
               Text("แก้ไข")
                    .foregroundColor(Color("blue_deep"))
                    .font(.custom("Prompt-Medium", size: 14, relativeTo: .body))
                    
            }
            .padding(.bottom,600)
            .padding(.leading,150)
            .opacity(selectedtab == "user" ? 1 : 0)
    
            
            ZStack{
                
                Image("circle")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom,550)
                    .padding(.trailing,225)
                    .opacity(selectedtab == "chart" ? 1 : 0)
                
                Text("ราคาขยะรีไซเคิลกลาง")
                    .font(.custom("Prompt-SemiBold", size:20, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .padding(.bottom,500)
                    .opacity(selectedtab == "chart" ? 1 : 0)
            
                Image("img_tab2")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom,300)
                    .opacity(selectedtab == "chart" ? 1 : 0)
       
                
                Button(action:  {
                        
                    self.showPaperDetailView.toggle()

                }) {
                   Text("กระดาษ")
                        .font(.custom("Prompt-Medium", size: 14, relativeTo: .body))
                        .frame(width:50,height:30)
                        .padding(.horizontal,40)
                }
                .foregroundColor(Color("blue_deep"))
                .background(Color.white)
                .cornerRadius(5)
                .padding(.bottom,90)
                .padding(.trailing,140)
                .opacity(selectedtab == "chart" ? 1 : 0)
                
            }.sheet(isPresented: $showPaperDetailView) {
                PaperDetailView(showPaperDetailView: self.$showPaperDetailView)
            }
                
            ZStack{
                    Button(action:  {
                            
                        self.showMetalDetailView.toggle()

                    }) {
                       Text("โลหะ")
                            .font(.custom("Prompt-Medium", size: 14, relativeTo: .body))
                            .frame(width:50,height:30)
                            .padding(.horizontal,40)
                    }
                    .foregroundColor(Color("blue_deep"))
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.bottom,380)
                    .padding(.leading,140)
                    .opacity(selectedtab == "chart" ? 1 : 0)
                    
                }.sheet(isPresented: $showMetalDetailView) {
                    MetalDetailView(showMetalDetailView: self.$showMetalDetailView)
                }
            
            ZStack{
                    Button(action:  {
                            
                        self.showPlassticDetailView.toggle()

                    }) {
                       Text("พลาสติก")
                            .font(.custom("Prompt-Medium", size: 13, relativeTo: .body))
                            .frame(width:50,height:30)
                            .padding(.horizontal,40)
                    }
                    .foregroundColor(Color("blue_deep"))
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.bottom,340)
                    .padding(.leading,140)
                    .opacity(selectedtab == "chart" ? 1 : 0)
                    
                }.sheet(isPresented: $showPlassticDetailView) {
                    PlassticDetailView(showPlassticDetailView: self.$showPlassticDetailView)
                }
            
            ZStack{
                
                Button(action:  {
                        
                    self.showGlassDetailView.toggle()

                }) {
                   Text("ขวดแก้ว")
                        .font(.custom("Prompt-Medium", size: 13, relativeTo: .body))
                        .frame(width:50,height:30)
                        .padding(.horizontal,40)
                }
                .foregroundColor(Color("blue_deep"))
                .background(Color.white)
                .cornerRadius(5)
                .padding(.bottom,340)
                .padding(.trailing,140)
                .opacity(selectedtab == "chart" ? 1 : 0)
                
            }.sheet(isPresented: $showGlassDetailView) {
                GlassDetailView(showGlassDetailView: self.$showGlassDetailView)
            }
            
            
           
            ZStack {
            
                VStack{
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            Text(settingsData.userInfo.name + " " + settingsData.userInfo.last_name)
                                .font(.custom("Prompt-SemiBold", size:20, relativeTo: .body))
                                .foregroundColor(Color.black)
                                .padding(.leading,20)
                                .padding(.top,10)
                                .opacity(selectedtab == "recycle" ? 1 : 0)
                            
                            
                            Text(settingsData.userInfo.address)
                                .font(.custom("Prompt-Light", size: 12, relativeTo: .body))
                                .foregroundColor(Color.black)
                                .frame(width:180)
                                .padding(.leading,20)
                                .padding(.bottom,20)
                                .opacity(selectedtab == "recycle" ? 1 : 0)
                            
                    }
                        
                        if settingsData.userInfo.pic != "" {

                                WebImage(url: URL(string: settingsData.userInfo.pic)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
//                                        .padding(.all,2)
//                                    .overlay(Circle().stroke(Color("ocean_deep"),lineWidth: 2))
                                    .padding(.leading,100)
                                    .padding(.bottom,20)
                                    .opacity(selectedtab == "recycle" ? 1 : 0)
                            
                    }
                        
                        Spacer()
                    }.padding(.top,40)
                    .background(Color.white)
                    .opacity(selectedtab == "recycle" ? 1 : 0)
                    
                    Spacer(minLength:0)
                    
                }
                
                VStack {
                    
                    RecycleDetailView(showRecycleDetailView: self.$showRecycleDetailView)
                        
                }.opacity(selectedtab == "content" ? 1 : 0)
                
                VStack {
                    
                    PickupView(showPickupView: self.$showPickupView)
                        
                }.opacity(selectedtab == "pickup" ? 1 : 0)
            
            }
            
    }
        
        
        GeometryReader { geometry in
              
            VStack {
                
                ListControlView(showListControlView: self.$showListControlView)
                    .frame(width: 370, height: 375)
                    .padding(.bottom,730)
                    .frame(width: geometry.size.width/1, height: geometry.size.height/2)
            }
        }.opacity(selectedtab == "recycle" ? 1 : 0)
        
        
        
}
    
    func getColor(image: String) -> Color {
        
        switch image {
        case "user":
            return Color("ocean_deep")
        case "chart":
            return Color("ocean_deep")
        case "recycle":
            return Color("ocean_deep")
        case "content":
            return Color("ocean_deep")
        case "pickup":
            return Color("ocean_deep")
        default:
            return Color.white
        }
    }
    
}

var tabs = ["user","chart","recycle","content","pickup"]


struct CustomShape: Shape {
    
    var xAxis: CGFloat
    var animatableData: CGFloat{
        
        get{return xAxis}
        set{xAxis = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
