//
//  ContentView.swift
//  JunkMove
//
//  Created by Supansa Ch on 1/18/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage


struct ContentView: View {
    
   
    @State var showHomeForSeller = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @State var showOTPView = false
    @State var loading = false
    
    var body: some View {
        
        
        VStack {
            
            if status {
                
                HomeForSeller(showHomeForSeller: self.$showHomeForSeller)
               
            }
            
            else {
                
                NavigationView {
                    
                    ZStack {
                    
                    VStack {
                    
                        ExplanPage()
                            .padding(.top,-90)
                        
                        Spacer()
                    
                        NavigationLink(destination: OtpView(showOTPView: self.$showOTPView )) {
                            
                            HStack {
                                
                                    Text("เริ่มต้นใช้งาน")
                                        .foregroundColor(.white)
                                        .frame(width: 270)
                                        .padding(.vertical,12)
                                        .padding(.horizontal,32)
                                        .font(.custom("Prompt-SemiBold", size: 18))
                            }
                                    .background(LinearGradient(gradient: Gradient(colors: [Color("ocean_deep"), Color("ocean_light")]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(5)
                            
                            }.padding()
                        }
                    }
                }.onAppear{
                    
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                        
                        let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                        
                        self.status = status
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






















