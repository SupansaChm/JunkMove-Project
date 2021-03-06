//
//  AppointModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct MsgModel: Codable,Identifiable,Hashable {
    
    @DocumentID var id : String?
    var msg : String
    var user : String
    var timeStamp : Date
    
    enum CodingKeys: String,CodingKey {
       
        case id
        case msg
        case user
        case timeStamp
    }
}
