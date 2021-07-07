//
//  SettingViewModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/17/21.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseAuth
import FirebaseFirestore
import CoreLocation

class SettingViewModel: ObservableObject {
    
    @State var showHomeForSeller  = false
    @AppStorage("current_status") var status = false
    @AppStorage("current_user") var userName = ""
    @Published var userInfo = UserModel(uid: "",name: "",phoneNumber: "", last_name: "", address: "", pic: "")
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    let phoneNumber = Auth.auth().currentUser!.phoneNumber
    init() {
        
        fetchUser()
    }
    
    func fetchUser() {
        
        ref.collection("SellerUser").document(uid).getDocument { (doc, err) in
            
            guard let user = doc else{return}
            
            let uid = user.data()?["uid"] as! String
            let name = user.data()?["name"] as! String
            let last_name = user.data()?["last_name"] as! String
            let address = user.data()?["address"] as! String
            let pic = user.data()?["imageurl"] as! String
            
            DispatchQueue.main.async {
                self.userName = name
                self.userInfo = UserModel(uid: uid, name: name, phoneNumber: self.phoneNumber ?? "", last_name: last_name, address: address, pic: pic)
            }
        }
    }
    
    func checkUser(completion: @escaping (Bool,String)->Void) {

        let ref = Firestore.firestore()
        
        
        ref.collection("SellerUser").getDocuments{ (snap, err) in

            if err != nil{

                
                return
            }

            for i in snap!.documents{

                if i.documentID == Auth.auth().currentUser?.uid {

                    completion(true,i.get("name") as! String)
                    return
                }
            }
            completion(false,"")
        }
    }

}
