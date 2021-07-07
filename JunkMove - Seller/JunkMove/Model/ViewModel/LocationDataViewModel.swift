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



class LocationDataViewModel : ObservableObject {
    
    @Published var locData = [LocationDataModel]()
    @AppStorage("current_status") var status = false
    @AppStorage("current_user") var userName = ""
    
    
}
