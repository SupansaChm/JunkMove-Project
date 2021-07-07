//
//  ChatModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI
import Firebase
import FirebaseDatabase

class ChatModel : ObservableObject{
    
    @Published var txt = ""
    @Published var msg : [MessageModel] = []
    @Published var chatRoomRef :DatabaseReference!
    @ObservedObject var truckList = TruckListModel()
    var settingsData = SettingViewModel()
    let uid = Auth.auth().currentUser!.uid
    
   
    
    func onAppear() {
        
        //        if settingsData.userName == user{
        //
        //            UIApplication.shared.windows.first?.rootViewController?.present(alertView(), animated: true)
        //        }
        UIApplication.shared.windows.first?.rootViewController?.present(alertView(), animated: true)
    }
    
    func alertView()->UIAlertController{
        
        let alert = UIAlertController(title: "เริ่มการนัดหมาย", message: "ต้องการนัดหมายรถรับซื้อ โปรดระบุชื่อ", preferredStyle: .alert)
        
        alert.addTextField { (txt) in
            
            txt.placeholder = "เช่น กนก"
        }
        
        let join = UIAlertAction(title: "เริ่มนัดหมาย", style: .default) { (_) in
            
            //            let user = alert.textFields![0].text ?? ""
            ////
            //            if user != ""{
            //
            //                settingsData.userName = user
            //                return
            //            }
            
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
        alert.addAction(join)
        return alert
    }
    
    let ref = Firestore.firestore()
    
//    func readAllMsgs(){
//
//        ref.collection("Msgs").order(by: "timeStamp", descending: false).addSnapshotListener { (snap, err) in
//
//            if err != nil {
//                print(err!.localizedDescription)
//                return
//            }
//            guard let data = snap else{return}
//
//            data.documentChanges.forEach { (doc) in
//
//                if doc.type == .added{
//
//                    let msg = try! doc.document.data(as: MsgModel.self)!
//
//                    DispatchQueue.main.async {
//
//                        self.msg.append(msg)
//                    }
//                }
//            }
//        }
//    }
    
    func readAllMsgs(){
        print("on in ==========")
        Firestore.firestore().collection("Messages").document("พิมพ์Oyr1GK8dxKPdFcdyInLFgyd1muy1").collection("chat").order(by: "timeStamp", descending: false).addSnapshotListener{ (snap,error) in
            guard let data = snap else{return}
            guard (snap?.documents) != nil else {return}
            
            data.documentChanges.forEach { (doc) in
                
                if doc.type == .added{
                    
                    let msg = try! doc.document.data(as: MessageModel.self)!
                    
                    DispatchQueue.main.async {
                        
                        self.msg.append(msg)
                    }
                }
            }
//            self.msg = documents.map{(item) -> MessageModel in
//                let data = item.data()
//
//                let senderId = data["senderId"] as? String
//                let senderDisplayName = data["senderDisplayName"] as? String
//                let text = data["text"] as? String
//                let profile = data["profile"] as? String
//                let timeStamp = data["timeStamp"] as? String
//
//                return MessageModel(id: senderId!, name: senderDisplayName!, profile: profile!, text: text!, isIncoming: true, timeStamp: timeStamp!)
//            }
        }
        
        
        
//        self.chatRoomRef = Database.database().reference(withPath: truckList.truckInfo.name + uid)
//
//        self.chatRoomRef.observe(.childAdded) { snapshot in
//            let messageDictionary = snapshot.value as? [String:Any] ?? [:]
//
//            self.msg = messageDictionary.map{(item)-> MessageModel in
//                let data = item
//                print("============================>",data)
////                let senderId = data["senderId"] as? String,
////                let senderDisplayName = data["senderDisplayName"] as? String
////                let text = data["text"] as? String
////                let profile = data["profile"] as? String
////                let timeStamp = data["timeStamp"] as? String
//                return MessageModel(id: "", name: "", profile: "", text: "" , isIncoming: true, timeStamp: "")
//            }
//            guard let senderId = messageDictionary["senderId"] as? String,
//                  let senderDisplayName = messageDictionary["senderDisplayName"] as? String else { return }
//            let text = messageDictionary["text"] as? String
//            let profile = messageDictionary["profile"] as? String
//            let timeStamp = messageDictionary["timeStamp"] as? String
            
//            DispatchQueue.main.async {
//                self.msg.insert(MessageModel(id: senderId, name: senderDisplayName, profile: profile!, text: text!+String(self.msg.count) , isIncoming: true, timeStamp: timeStamp!), at:  self.msg.count)
//                print("============",MessageModel(id: senderId, name: senderDisplayName, profile: profile!, text: text ?? "", isIncoming: true, timeStamp: timeStamp!))
//            }
            
//    func readAllMsgs2(){
//
//        ref.collection("Msgs").order(by: "timeStamp", descending: false).addSnapshotListener { (snap, err) in
//
//            if err != nil {
//                print(err!.localizedDescription)
//                return
//            }
//            guard let data = snap else{return}
//
//            data.documentChanges.forEach { (doc) in
//
//                if doc.type == .added{
//
//                    let msg = try! doc.document.data(as: MsgModel.self)!
//
//                    DispatchQueue.main.async {
//
//                        //                        self.msg.append(msg)
//                    }
//                }
//            }
//        }
//    }

    }
    
    func writeMsg(){
        
        let time = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm"
        
        Firestore.firestore().collection("Messages").document("พิมพ์Oyr1GK8dxKPdFcdyInLFgyd1muy1").collection("chat").addDocument(data: [
            "profile": "",
            "senderDisplayName" : settingsData.userName,
            "text" : txt,
            "timeStamp" : formatter1.string(from: time)
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ")
            }
        }
   
 
        self.txt = ""
        
        
        //        let msg = MsgModel(msg: txt, user: user, timeStamp: Date())
        //        let _ = try! ref.collection("Msgs").addDocument(from: msg) { (err) in
        //
        //            if err != nil {
        //
        //                print(err!.localizedDescription)
        //                return
        //            }
        //
        //            self.txt = ""
        //        }
        }
}
