//
//  OtpView.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/16/21.
//

import SwiftUI
import FirebaseAuth

struct OTPView : View {
    
    @State var ccode = "+66"
    @State var no = ""
    @State var showVerifyView = false
    @State var msg = "รหัสของคุณไม่ถูกต้อง โปรดลองอีกครั้ง"
    @State var alert = false
    @State var ID = ""
    @State var loading = false
    @Binding var showOTPView : Bool
    
    var body: some View {

        VStack{
            HStack {
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Image("circle")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
                    .padding(.leading,-380)
                    .padding(.top,-20)
                    
            }
            
            VStack{
               
                Image("img_otp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0)
                    .padding(.top,-90)
            
            };Spacer(minLength: 0)
                
            ZStack {
                
                Spacer(minLength: 0)
                Text("ยินดีต้อนรับ")
                    .font(.custom("Prompt-SemiBold", size: 20))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .padding(.top,-30)
            
                
                Text("โปรดใส่เบอร์มือถือของคุณเพื่อรับรหัสยืนยัน")
                    .font(.custom("Prompt-Light", size: 15, relativeTo: .body))
                    .foregroundColor(.black)
                    .padding(.top,25)
            }

            
            VStack {
                
                HStack {
    
                    TextField("+66",text: $ccode)
                        .keyboardType(.numberPad)
                        .frame(width: 45)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color("light_grey"))
                        .font(.custom("Prompt-Light", size: 18, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
   
                    TextField("ระบุเบอร์มือถือ",text: $no)
                        .keyboardType(.numberPad)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color("light_grey"))
                        .font(.custom("Prompt-Light", size: 18, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .frame(width: 270)
            
                        
                    
                };Spacer()
                .padding(.top,-150)
                    
                NavigationLink(destination: VerifyView(showVerifyView: $showVerifyView, ID: $ID),isActive: $showVerifyView){
                    
                    Button(action: {
                        
//                        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                        PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.ccode+self.no, uiDelegate: nil) { (ID, err) in
                            
                            if err != nil {
                                
                                self.msg = (err?.localizedDescription)!
                                self.alert.toggle()
                                return
                                
                            }
                            
                                self.ID = ID!
                                self.showVerifyView.toggle()
                                return
                            
                        }
                        
                        
                    }) {
                        Text("ขอรหัสยืนยัน")
                            .font(.custom("Prompt-SemiBold", size: 18, relativeTo: .body))
                            .frame(width: 270)
                            .padding(.vertical,12)
                            .padding(.horizontal,32)
                    }.foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("ocean_deep"), Color("ocean_light")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
            }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                
        }.padding(.bottom,15)
            
            .alert(isPresented: $alert) {
            
                Alert(title: Text("เกิดข้อผิดพลาด"), message: Text(self.msg), dismissButton: .default(Text("ปิด")))
            
            }
        }
    }
}
