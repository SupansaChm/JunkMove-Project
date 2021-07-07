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
    
    @State var showHomeView  = false
    @AppStorage("current_status") var status = false
    @AppStorage("current_user") var stName = ""
    @Published var userInfo = UserModel(uid: "", storeName: "", truckNumber: "",phoneNumber: "", timeClose: "", timeOpen: "", moreDetail: "", address: "", truck_point: "", truck_distance: "", pic: "")
    
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    let phoneNumber = Auth.auth().currentUser!.phoneNumber
    
    init() {
        
        fetchUser()
    }
    
    func fetchUser() {
        
        ref.collection("TruckUser").document(uid).getDocument { (doc, err) in
            
            guard let user = doc else{return}
            
            let uid = user.data()?["uid"] as! String
            let storeName = user.data()?["storeName"] as! String
            let truckNumber = user.data()?["truckNumber"] as! String
            let truck_point = user.data()?["truck_point"] as! String
            let truck_distance = user.data()?["truck_distance"] as! String
            let timeClose = user.data()?["timeClose"] as! String
            let timeOpen = user.data()?["timeOpen"] as! String
            let moreDetail = user.data()?["moreDetail"] as! String
            let address = user.data()?["address"] as! String
            let pic = user.data()?["imageurl"] as! String
            
            DispatchQueue.main.async {
                self.userInfo = UserModel(uid: uid, storeName: storeName, truckNumber: truckNumber, phoneNumber: self.phoneNumber ?? "", timeClose: timeClose, timeOpen: timeOpen, moreDetail: moreDetail, address: address, truck_point: truck_point, truck_distance: truck_distance, pic: pic)
            }
        }
    }
    
    func CheckUser(completion: @escaping (Bool,String)->Void) {

        let ref = Firestore.firestore()
        
        
        ref.collection("TruckUser").getDocuments{ (snap, err) in

            if err != nil{

                
                return
            }

            for i in snap!.documents{

                if i.documentID == Auth.auth().currentUser?.uid {

                    completion(true,i.get("storeName") as! String)
                    return
                }
            }
            completion(false,"")
        }
    }

}
