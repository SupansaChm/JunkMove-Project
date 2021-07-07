//
//  acountCreateViewModel.swift
//  JunkMove
//
//  Created by Supansa Ch on 2/16/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage

class acountCreateViewModel: NSObject,CLLocationManagerDelegate,ObservableObject {
    
    @Published var locationManager = CLLocationManager()
    
    // location detail
    
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
  
    
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
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
        
    }
}
