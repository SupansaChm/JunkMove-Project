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

struct sellerRegister: View {
    
    @Binding var showSellerRegister : Bool
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var showHomeForSeller  = false
    @StateObject var sellerRegisterData = SellerRegisterViewModel()
  
   
    var body: some View {
        
        ZStack {
            
        VStack {
            
            Image("circle")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.top,-20)
                .padding(.leading,-200)
            
            Image("img_register1")
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(.top,-50)
                .padding(.leading,20)
        
            Text("ประเภท: ต้องการขาย")
                .font(.custom("Prompt-SemiBold", size: 18))
            
            Text("ใส่ข้อมูลของคุณอีกเพียงเล็กน้อย")
                .font(.custom("Prompt-Light", size: 15, relativeTo: .body))
          
            
            ZStack{
                
                if sellerRegisterData.img_Data.count == 0 {
                
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color("medium_grey"))
                    .frame(width: 95, height: 95)
                    .background(Color.white)
                    .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white,lineWidth: 3)
                            .shadow(color: .black, radius: 4, x: 3, y: 3).opacity(0.08))
                    
                } else {
                    
                    Image(uiImage: UIImage(data: sellerRegisterData.img_Data)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 95, height: 95)
                    .clipShape(Circle())
                        .padding(.all,5)
                        .overlay(Circle().stroke(Color("ocean_deep"),lineWidth: 1))
                }
            }
                .padding()
                .onTapGesture(perform: {
                sellerRegisterData.picker.toggle()
            })
                
            
            TextField("ชื่อ",text: $sellerRegisterData.name)
                .frame(width: 320)
                .padding(.leading,10)
                .padding(.all,2)
                .background(Color(.white))
                .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            TextField("นามสกุล",text: $sellerRegisterData.last_name)
                .frame(width: 320)
                .padding(.leading,10)
                .padding(.all,2)
                .background(Color(.white))
                .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                .clipShape(RoundedRectangle(cornerRadius: 10))
               
            
            TextField("ที่อยู่ของคุณ",text: $sellerRegisterData.userAddress)
                .frame(width: 320)
                .padding(.leading,10)
                .padding(.all,2)
                .background(Color(.white))
                .font(.custom("Prompt-Light", size: 16, relativeTo: .body))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if sellerRegisterData.loading{
                
                ProgressView()
                    .padding()
            }
            else{
                
                Button(action: sellerRegisterData.register, label: {
                   
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
            
                sellerRegisterData.locationManager.delegate = sellerRegisterData
            
           
            })
            
            }.sheet(isPresented: self.$sellerRegisterData.picker,
                content: { ImagePicker(picker: self.$sellerRegisterData.picker,
                img_Data: self.$sellerRegisterData.img_Data)
            })
            
        }
    }

