//
//  SellerRegisterViewModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/18/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage
import Foundation


class SellerRegisterViewModel: NSObject,CLLocationManagerDelegate,ObservableObject {
    
    
    @Published  var img_Data = Data(count: 0)
    @Published  var picker = false
    @Published  var loading = false
    @Published  var name = ""
    @Published  var last_name = ""
    
    
    @Published var locationManager = CLLocationManager()    
    // location detail
    
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    @AppStorage("current_status") var status = false
    
    let ref = Firestore.firestore()
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
       //checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = true
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknow")
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // read user location
        self.userLocation = locations.last
        self.extractLocation()
        
    }
    
    func extractLocation(){
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else{return}
            
            var address = ""
            
            // getting area and locality name...
            
            address += safeData.first?.subThoroughfare ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            address += ", "
            address += safeData.first?.administrativeArea ?? ""
            
            self.userAddress = address
        }
        
    }
   
    func register() {
        
        loading = true
        let uid = Auth.auth().currentUser!.uid
        
        UpLoadImage(imageData: img_Data, path: "profile_Photos") { (url) in
            
            self.ref.collection("SellerUser").document(uid).setData([
                
                "uid" : uid,
                "imageurl": url,
                "name" : self.name,
                "last_name" : self.last_name,
                "address": self.userAddress,
                "dateCreate": Date()
                
            
            ]) { (err) in
                
                if err != nil {
                    
                    self.loading = false
                    return
                }
                self.loading = false
                self.status = true
            }
        }
        
    }
}
