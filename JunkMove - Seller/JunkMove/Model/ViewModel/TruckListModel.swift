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



class TruckListModel: ObservableObject {
    
    @Published var datas = [TruckModel]()
    @Published var truckInfo = TruckModel(id: "",storeName: "", truckNumber: "", timeClose: "",timeOpen:"", moreDetail:"", address:"", truck_point:"", truck_distance:"", pic:"")
    
   init() {
        
        let ref = Firestore.firestore()
        
        ref.collection("TruckUser").order(by: "truck_distance").addSnapshotListener{ (snap, err) in
            
            if err != nil {
                
                print((err?.localizedDescription)!)
                return
                
                
            }
            
            for i in snap!.documentChanges{
                
                let id = i.document.documentID
                let storeName = i.document.get("storeName") as! String
                let truckNumber = i.document.get("truckNumber") as! String
                let address = i.document.get("address") as! String
                let timeClose = i.document.get("timeClose") as! String
                let timeOpen = i.document.get("timeOpen") as! String
                let moreDetail = i.document.get("moreDetail") as! String
                let truck_point = i.document.get("truck_point") as! String
                let truck_distance = i.document.get("truck_distance") as! String
                let pic = i.document.get("imageurl") as! String
                
                self.datas.append(TruckModel(id: id, storeName: storeName, truckNumber: truckNumber, timeClose: timeClose, timeOpen: timeOpen, moreDetail: moreDetail, address: address, truck_point: truck_point, truck_distance: truck_distance, pic: pic))
                
                DispatchQueue.main.async {
                                
                    self.truckInfo = TruckModel(id: id, storeName: storeName, truckNumber: truckNumber, timeClose: timeClose, timeOpen: timeOpen, moreDetail: moreDetail, address: address, truck_point: truck_point, truck_distance: truck_distance, pic: pic)
                                }
            }
        }
    }
}
