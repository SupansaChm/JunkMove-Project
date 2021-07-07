//
//  sellerRegister.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/16/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage

struct RegisterView: View {
    
    @Binding var showRegisterView : Bool
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var showHomeView  = false
    @State var showTabView  = false
    @StateObject var RegisterData = RegisterViewModel()
    @State var loading = false
    @State var pushActive = false
    @AppStorage("current_identity") var identity = false
  
   
    var body: some View {
        
        ZStack {
            
        VStack {
            
            Image("circle_2")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.top,-20)
                .padding(.leading,-200)
            
            Image("img_register2")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 90)
                .padding(.top,-70)
                .padding(.leading,20)
        
            Text("ประเภท: รถรับซื้อ")
                .font(.custom("Prompt-SemiBold", size: 18))
            
            Text("ใส่ข้อมูลของคุณอีกเพียงเล็กน้อย")
                .font(.custom("Prompt-Light", size: 15, relativeTo: .body))
            
            ZStack{
                
                if RegisterData.img_Data.count == 0 {
                
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color("medium_grey"))
                    .frame(width: 95, height: 95)
                    .background(Color.white)
                    .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white,lineWidth: 3)
                            .shadow(color: .black, radius: 4, x: 3, y: 3).opacity(0.08))
                    
                } else {
                    
                    Image(uiImage: UIImage(data: RegisterData.img_Data)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 95, height: 95)
                    .clipShape(Circle())
                        .padding(.all,5)
                        .overlay(Circle().stroke(Color("violet_light"),lineWidth: 2))
                }
            }
                .padding()
                .onTapGesture(perform: {
                RegisterData.picker.toggle()
            })
        
            ZStack {
                
            VStack {
                
                    TextField("ชื่อร้าน",text: $RegisterData.storeName)
                        .frame(width: 320)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color(.white))
                        .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                
                    TextField("เลขทะเบียน",text: $RegisterData.truckNumber)
                        .frame(width: 320)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color(.white))
                        .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
               
                HStack{
                    
                    TextField("เวลาเริ่มรับซืื้อ",text: $RegisterData.timeOpen)
                        .frame(width: 120)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color(.white))
                        .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(" จนถึง ")
                        .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                        .foregroundColor(.black)
                    
                    TextField("เวลาเริ่มรับซืื้อ",text: $RegisterData.timeClose)
                        .frame(width: 120)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color(.white))
                        .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
                    TextField("รายละเอียดเพิ่มเติม",text: $RegisterData.moreDetail)
                        .frame(width: 320)
                        .padding(.leading,10)
                        .padding(.all,2)
                        .background(Color(.white))
                        .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                
                }
            
            }
            
            TextField("ที่อยู่ของคุณ",text: $RegisterData.userAddress)
                .frame(width: 320)
                .padding(.leading,10)
                .padding(.all,2)
                .background(Color(.white))
                .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            if RegisterData.loading{
                
                ProgressView()
                    .padding()
            }
            else{
                
                Button(action: RegisterData.register, label: {
                   
                    Text("บันทึก")
                        .font(.custom("Prompt-SemiBold", size: 18, relativeTo: .body))
                        .frame(width: 270)
                        .padding(.vertical,12)
                        .padding(.horizontal,32)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("ocean_deep"), Color("ocean_light")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5)
                        .padding()
                })
            }
               
             
                
            
            Spacer(minLength: 0)
            .padding(.horizontal,200)
            
            }
    
            .background(Color("light_grey")).ignoresSafeArea(.all,edges: .all)
            
            .onAppear(perform:{
            
            // calling location delegate
            
               RegisterData.locationManager.delegate = RegisterData
            
           
            })
            
            }.sheet(isPresented: self.$RegisterData.picker,
                content: { ImagePicker(picker: self.$RegisterData.picker,
                img_Data: self.$RegisterData.img_Data)
            })
            
        
        }
    }


