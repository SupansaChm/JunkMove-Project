//
//  ChatBubbles.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI

struct ChatBubbles: Shape {
    
    var myMsg : Bool
    
    func path(in rect: CGRect) -> Path {
    
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight, myMsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 15, height: 15))
    
        return Path(path.cgPath)
    }
}

