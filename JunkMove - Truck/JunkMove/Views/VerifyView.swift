//
//  VerifyViewFotTruck.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/30/21.
//

import SwiftUI
import FirebaseAuth

struct VerifyView : View {
    
    @State var code = ""
    @Binding var showVerifyView : Bool
    @Binding var ID : String
    @State var msg = ""
    @State var alert = false
    @State var loading = false
    @State var showRegisterView = false
    
    
    var body: some View {
        
        ZStack{
            
            GeometryReader{ _ in
                
            }
        
            HStack {
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Image("circle")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
                    .padding(.leading,-380)
                    .padding(.top,-350)
                    
            }
            
            VStack{
               
                Image("img_verify")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0)
                    .padding(.top,-300)
            
            };Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            ZStack {
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Text("รหัสจะถูกส่งมาทาง SMS")
                    .font(.custom("Prompt-SemiBold", size: 20))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .padding(.top,-100)
                
               
                Text("โปรดใส่รหัสที่คุณได้รับ")
                    .font(.custom("Prompt-Light", size: 15, relativeTo: .body))
                    .foregroundColor(.black)
                    .padding(.top,-70)
         
             
            }
            
            VStack {
          
                    TextField("รหัส 6 หลัก",text: $code)
                        .keyboardType(.numberPad)
                        .frame(width: 320)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color("light_grey"))
                        .font(.custom("Prompt-Light", size: 18, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.top,-30)
   
            };Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
          
                
            if self.loading{
                
                HStack{
                    
                    Spacer()
                    
                    Indicator()
                    
                    Spacer()
                }
            }
            else {
                
                Button(action: {
                    
                    self.loading.toggle()
                    
                    let credential =
                    PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                    
                    Auth.auth().signIn(with: credential) { (res, err) in
                        
                        if err != nil {
                            
                            self.msg = (err?.localizedDescription)!
                            self.alert.toggle()
                            self.loading.toggle()
                            return
                            
                        }
                        
                        CheckUser { (exists, user) in
                            
                            if exists {
                                
                                UserDefaults.standard.setValue(true, forKey: "status")
                                
                                UserDefaults.standard.setValue(user, forKey: "UserName")
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "statusChange"), object: nil)
                            }
                            
                            else {
                                
                                self.loading.toggle()
                                self.showRegisterView.toggle()
                                
                            }
                        }
                    }
                    
                }) {
                    Text("ยืนยัน")
                        .font(.custom("Prompt-SemiBold", size: 18, relativeTo: .body))
                        .frame(width: 270)
                        .padding(.vertical,12)
                        .padding(.horizontal,32)
                }.foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("ocean_deep"), Color("ocean_light")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                .padding(.top,100)
                
            }
                
            
            
            VStack {
            
            ZStack(alignment: .topLeading ) {
               
                Button(action: {
                    
                    self.showVerifyView.toggle()
                    
                }){
                    
                    Image(systemName: "chevron.left").font(.title2)
                }.foregroundColor(.black)
                .padding(.top,-610)
                .padding(.leading,-160)
                
            }
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            .alert(isPresented: $alert) {
            
                Alert(title: Text("เกิดข้อผิดพลาด"), message: Text(self.msg), dismissButton: .default(Text("ปิด")))
            
            }
            
                .fullScreenCover(isPresented: $showRegisterView) {
                    RegisterView(showRegisterView: self.$showRegisterView)
                }
            }
        }
    }
}
