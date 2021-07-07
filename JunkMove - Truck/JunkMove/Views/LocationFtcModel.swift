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

class LocationFtcModel: ObservableObject {
    
   
    @Published var locInfo = LocModel(id: "", lat: "", long: "")
    

    
    let ref = Firestore.firestore()
    let id = Auth.auth().currentUser!.uid
  
    
    init() {
        
        fetchLoc()
    }
    
    func fetchLoc() {
        
        ref.collection("Selleruser").document(id).getDocument { (doc, err) in
            
            guard let user = doc else{return}
            
            let id = user.data()?["id"] as! String
            let lat = user.data()?["lat"] as! String
            let long = user.data()?["long"] as! String
            
            
            DispatchQueue.main.async {
                self.locInfo = LocModel(id: id, lat: lat, long: long)
            }
        }
    }
}
