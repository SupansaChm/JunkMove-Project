//
//  priceModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/26/21.
//

import SwiftUI

struct PriceModel: Identifiable {
    var id = UUID().uuidString
    var name : String
    var price : String
   
}


struct RecModel: Identifiable {
    var id = UUID().uuidString
    var waste_title : String
    var waste_detail : String
   
}

var wastePrice = [

    RecModel(waste_title: "กระดาษ", waste_detail: "กล่องกระดาษ หนังสือพิมพ์ และอื่นๆ"),
    RecModel(waste_title: "โลหะ", waste_detail: "กระป๋องน้ำอัดลม สังกะสี เศษโลหะต่างๆ"),
    RecModel(waste_title: "พลาสติก", waste_detail: "ขวดพลาสติก เศษพลาสติก และอื่นๆ"),
    RecModel(waste_title: "ขวดแก้ว", waste_detail: "ขวดแก้วสีชา ขวดแก้วใส ขวดแก้วรวม"),

]

