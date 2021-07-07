//
//  TruckListModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/1/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage
import Foundation



class SellerListModel: ObservableObject {
    
    @Published var datas = [SellerModel]()
    @Published var sellerInfo = SellerModel(id: "", name: "", last_name: "", address: "", pic: "")
    
   init() {
        
        let ref = Firestore.firestore()
        
        ref.collection("SellerUser").addSnapshotListener{ (snap, err) in
            
            if err != nil {
                
                print((err?.localizedDescription)!)
                return
                
                
            }
            
            for i in snap!.documentChanges{
                
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let last_name = i.document.get("last_name") as! String
                let address = i.document.get("address") as! String
                let pic = i.document.get("imageurl") as! String
                
                self.datas.append(SellerModel(id: id, name: name,last_name: last_name, address: address, pic: pic))
                
                DispatchQueue.main.async {
                                
                    self.sellerInfo = SellerModel(id: id, name: name,last_name: last_name, address: address, pic: pic)
                                }
            }
        }
    }
}
