//
//  checkUser.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/16/21.
//

import Foundation
import Firebase

func checkUser(completion: @escaping (Bool,String)->Void) {

    let ref = Firestore.firestore()

    
    ref.collection("SellerUser").getDocuments{ (snap, err) in

        if err != nil{

            print((err?.localizedDescription)!)
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
