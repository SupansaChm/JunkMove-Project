//
//  addUserType1.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/16/21.
//

import Foundation
import Firebase

func addUserType(name: String, last_name : String, address : String, img_Data : Data,completion : @escaping(Bool)->Void){
    
    let db = Firestore.firestore()
    
    let storage = Storage.storage().reference()
    
    let uid = Auth.auth().currentUser?.uid
    
    storage.child("profilepics").child(uid!).putData(img_Data, metadata: nil){
        (_,err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    storage.child("profilepics").child(uid!).downloadURL{ (url, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
        
        
        db.collection("SellerUser").document(uid!).setData(
            [
                "name" : name,
                "last_name" : last_name,
                "address" : address,
                "profilepics" : "\(url!)",
                "id" : uid!
        
            ])
                { (err) in
            
                if err != nil {
                
                    print((err?.localizedDescription)!)
                    return
                }
            
                completion(true)
            
                UserDefaults.standard.set(true, forKey: "status")
            
                UserDefaults.standard.set(name, forKey: "name")
            
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
        }
    }
}

// this function no use
