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

struct CustomTabView: View {
    
    @Binding var showTabView : Bool
    @StateObject var settingsData = SettingViewModel()
    @StateObject var RegisterData = RegisterViewModel()
    @State var showOTPView = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @AppStorage("current_identity") var identity = false
    @State var selectedtab = "user"
    @ObservedObject var sellerList = SellerListModel()
    @State var showSellerListView = false
    @State var showSellerChatView = false
    @State var showPaperDetailView = false
    @State var showMetalDetailView = false
    @State var showPlassticDetailView = false
    @State var showGlassDetailView = false
    @State var showCommentView = false
    @State var showTableView = false
    
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
                    .tag("price")
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("chat")
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("point")
                
                Color("light_grey")
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("table")
                
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

                    ZStack{
                        
                        WebImage(url: URL(string: settingsData.userInfo.pic)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                                .padding(.all,5)
                            .overlay(Circle().stroke(Color("blue_deep"),lineWidth: 1))
                            .padding(.bottom,450)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    }
                    
                }
                
                        Text(settingsData.userInfo.storeName)
                            .font(.custom("Prompt-SemiBold", size:20, relativeTo: .body))
                            .foregroundColor(Color("blue_deep"))
                            .padding(.bottom,260)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Image("circle_2")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.bottom,550)
                            .padding(.trailing,225)
                            .opacity(selectedtab == "user" ? 1 : 0)
                  
                        Text("ชื่อร้าน  ")
                            .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                            .padding(.bottom,100)
                            .padding(.trailing,250)
                            .opacity(selectedtab == "user" ? 1 : 0)
                        
                        Text(settingsData.userInfo.storeName)
                            .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                            .foregroundColor(Color("blue_deep"))
                            .padding(.bottom,100)
                            .padding(.leading,100)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Divider()
                            .frame(width:320)
                            .padding(.bottom,60)
                            .opacity(selectedtab == "user" ? 1 : 0)
                
                    
                        Text("รายละเอียด  ")
                            .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                            .foregroundColor(Color.gray)
                            .padding(.bottom,10)
                            .padding(.trailing,225)
                            .opacity(selectedtab == "user" ? 1 : 0)
                    
                        Text(settingsData.userInfo.moreDetail)
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
                OTPView(showOTPView: self.$showOTPView)
                
            }
            
            ZStack {
                
                    Text("เปิด - ปิด  ")
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.gray)
                        .padding(.bottom,300)
                        .padding(.trailing,230)
                        .opacity(selectedtab == "user" ? 1 : 0)
            
                    Text(settingsData.userInfo.timeOpen + " จนถึง " + settingsData.userInfo.timeClose)
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color("blue_deep"))
                        .padding(.bottom,300)
                        .padding(.leading,100)
                        .opacity(selectedtab == "user" ? 1 : 0)
        
                    Divider()
                        .frame(width:320)
                        .padding(.bottom,260)
                        .opacity(selectedtab == "user" ? 1 : 0)
                
                
                    Text("เบอร์โทรศัพท์  ")
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color.gray)
                        .padding(.bottom,210)
                        .padding(.trailing,210)
                        .opacity(selectedtab == "user" ? 1 : 0)
            
                    Text(settingsData.userInfo.phoneNumber)
                        .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                        .foregroundColor(Color("blue_deep"))
                        .padding(.bottom,210)
                        .padding(.leading,100)
                        .opacity(selectedtab == "user" ? 1 : 0)
        
                    Divider()
                        .frame(width:320)
                        .padding(.bottom,160)
                        .opacity(selectedtab == "user" ? 1 : 0)
                
                Text("ที่อยู่ ")
                    .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                    .foregroundColor(Color.gray)
                    .padding(.bottom,110)
                    .padding(.trailing,265)
                    .opacity(selectedtab == "user" ? 1 : 0)
        
                Text(settingsData.userInfo.address)
                    .font(.custom("Prompt-light", size: 14, relativeTo: .body))
                    .foregroundColor(Color("blue_deep"))
                    .padding(.bottom,110)
                    .padding(.leading,100)
                    .opacity(selectedtab == "user" ? 1 : 0)
    
                Divider()
                    .frame(width:320)
                    .padding(.bottom,60)
                    .opacity(selectedtab == "user" ? 1 : 0)
            }
            
            Button(action:  {
                    

            }) {
               Text("แก้ไข")
                    .foregroundColor(Color("blue_deep"))
                    .font(.custom("Prompt-Medium", size: 14, relativeTo: .body))
                    
            }
            .padding(.bottom,630)
            .padding(.leading,150)
            .opacity(selectedtab == "user" ? 1 : 0)
    
            
            VStack{
                
                Image("client")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 360)
                    .padding(.leading,20)
                    .padding(.bottom,50)
                    .opacity(selectedtab == "chat" ? 1 : 0)
                
            VStack{
                
                VStack{
                
                    ForEach(self.sellerList.datas){i in

                    HStack {
                        
                        if sellerList.sellerInfo.pic != "" {

                                WebImage(url: URL(string: sellerList.sellerInfo.pic)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .padding(.all,3)
                                    .overlay(Circle().stroke(Color("ocean_deep"),lineWidth: 1.5))
                            
                        }
                
                        VStack(alignment: .leading) {
                            
                            Text(i.name)
                                .font(.custom("Prompt-SemiBold", size: 14, relativeTo: .body))
                                .foregroundColor(Color.black)
                                
                            
                            HStack{
                                
                                Text(i.address)
                                    .font(.custom("Prompt-Light", size: 14, relativeTo: .body))
                                    .foregroundColor(Color.gray)
                                    
                                }
                            }
                        .padding()
                        }
                        
                    .onTapGesture {

                        self.showSellerChatView.toggle()

                        }

                    .sheet(isPresented: $showSellerChatView) {

                        SellerChatView(showSellerChatView: self.$showSellerChatView)

                        }
                 
                    }
                }.opacity(selectedtab == "chat" ? 1 : 0)
                .padding(.bottom,200)
            }
        }
            ZStack {
            
                ZStack{
                
                Image("circle_2")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom,550)
                    .padding(.trailing,225)
                    .opacity(selectedtab == "price" ? 1 : 0)
                
                Text("ราคาขยะรีไซเคิลกลาง")
                    .font(.custom("Prompt-SemiBold", size:20, relativeTo: .body))
                    .foregroundColor(Color.black)
                    .padding(.bottom,500)
                    .opacity(selectedtab == "price" ? 1 : 0)
            
                Image("img_tab2")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom,300)
                    .opacity(selectedtab == "price" ? 1 : 0)
       
                
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
                .opacity(selectedtab == "price" ? 1 : 0)
                
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
                    .padding(.bottom,90)
                    .padding(.leading,140)
                    .opacity(selectedtab == "price" ? 1 : 0)
                    
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
                    .padding(.bottom,10)
                    .padding(.leading,140)
                    .opacity(selectedtab == "price" ? 1 : 0)
                    
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
                .padding(.bottom,10)
                .padding(.trailing,140)
                .opacity(selectedtab == "price" ? 1 : 0)
                
            }.sheet(isPresented: $showGlassDetailView) {
                GlassDetailView(showGlassDetailView: self.$showGlassDetailView)
            }
                
        }
            
            GeometryReader { geometry in
                  
                VStack {
                    
                   CommentView(showCommentView: self.$showCommentView)
                        .frame(width: 370, height: 375)
                        .padding(.top,350)
                        .frame(width: geometry.size.width/1, height: geometry.size.height/2)
                }
            }.opacity(selectedtab == "point" ? 1 : 0)

            
            GeometryReader { geometry in
                  
                VStack {
                    
                    TableView(showTableView: self.$showTableView)
                        .frame(width: 370, height: 375)
                        .padding(.top,350)
                        .frame(width: geometry.size.width/1, height: geometry.size.height/2)
                }
            }.opacity(selectedtab == "table" ? 1 : 0)
    }
       
}
    
    func getColor(image: String) -> Color {
        
        switch image {
        case "user":
            return Color("ocean_deep")
        case "price":
            return Color("ocean_deep")
        case "chat":
            return Color("ocean_deep")
        case "point":
            return Color("ocean_deep")
        case "table":
            return Color("ocean_deep")
        default:
            return Color.white
        }
    }
    
}

var tabs = ["user","price","chat","point","table"]


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
