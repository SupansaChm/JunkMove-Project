//
//  messageModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct MessageModel : Codable,Identifiable,Hashable{
    
    @DocumentID var id : String?
    var senderDisplayName: String
    var profile: String
    var text: String
    var timeStamp : String
    
    enum CodingKeys: String,CodingKey {
        
        case id
        case senderDisplayName
        case profile
        case text
        case timeStamp
    }

}
