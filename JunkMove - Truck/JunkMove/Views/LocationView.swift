//
//  LocationView.swift
//  JunkMove
//
//  Created by Supansa Ch on 5/12/21.
//


import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import FirebaseStorage
import Foundation
import SDWebImageSwiftUI
import FirebaseDatabase
import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct LocationView: View {
    
    
    @State var locInfo = LocModel(id: "", lat: "", long: "")
    @State var showLocationView : Bool
    
    let annotations = [
           City(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
           City(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
           City(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
           City(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
       ]
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))


       var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) {
            MapPin(coordinate: $0.coordinate)
                }
            .padding(.all)
            .frame(width: 360, height: 560)
            .cornerRadius(20)
            
       }
}


//_________________________________________________________________________________________//

struct Direction : View {
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @Binding var showDirection : Bool
    @State var alert = false
    @State var source : CLLocationCoordinate2D!
    @State var destination : CLLocationCoordinate2D!
    @State var name = ""
    @State var distance = ""
    @State var time = ""
    @State var showAllMapView = false
    @State var loading = false
    @State var book = false
    @State var doc = ""
    @State var data : Data = .init(count: 0)
    @State var search = false
    @State var showTableView = false
    
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .bottom) {
                
                VStack(spacing: 0 ){
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10){
                            
                            Text(self.destination != nil ? "กำลังค้นหาเส้นทาง" : "เลือกตำแหน่งที่ต้องการเดินทาง")
                                .font(.custom("Prompt-SemiBold", size: 18))
                                .foregroundColor(Color("blue_deep"))
                            
                            if self.destination != nil{
                                
                                Text(self.name)
                                    .font(.custom("Prompt-Regular", size: 14))
                                    .foregroundColor(Color("blue_deep"))
                            }
                        }
                        
                        Spacer()
                        
                        Button(action:{
                           
                            self.search.toggle()
                            
                        }){
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    
                    MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination, name: self.$name, distance: self.$distance, time: self.$time, showAllMapView: self.$showAllMapView)
                    .onAppear(){
                           
                        self.manager.requestAlwaysAuthorization()
                    }
                }
                
                if self.destination != nil && self.showAllMapView{
                    
                    ZStack(alignment: .topTrailing ){
                        
                        
                        VStack(spacing: 10){
                            
                            HStack{
                                
                                VStack(alignment:.leading,spacing: 10) {
                                    
                                    Text("ค้นหาเส้นทาง")
                                        .font(.custom("Prompt-Bold", size: 18))
                                        .foregroundColor(Color("blue_deep"))
                                    
                                    Text(self.name)
                                        .font(.custom("Prompt-Regular", size: 14))
                                        .foregroundColor(Color("blue_deep"))
                                    
                                    Text("ระยะทาง : " + self.distance + " กิโลเมตร")
                                        .font(.custom("Prompt-Regular", size: 14))
                                        .foregroundColor(Color("blue_deep"))
                                    
                                    Text("เวลาในการเดินทาง : " + self.time + " นาที")
                                        .font(.custom("Prompt-Regular", size: 14))
                                        .foregroundColor(Color("blue_deep"))
                                }
                                
                                Spacer()
                            }
                            
                            Button(action: {
                                
                                self.showTableView.toggle()
                                
                            }) {
                                
                                Text("บันทึกเส้นทาง")
                                    .font(.custom("Prompt-SemiBold", size: 16))
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .frame(width: UIScreen.main.bounds.width / 2)
                            }
                            .background(LinearGradient(gradient: Gradient(colors: [Color("violet_light"), Color("violet_clear")]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                            
                        }.sheet(isPresented: $showTableView) {
                            
                            TableView(showTableView: self.$showTableView)

                        }
                        
                        Button(action: {
                            
                            self.map.removeOverlays(self.map.overlays)
                            self.map.removeAnnotations(self.map.annotations)
                            self.destination = nil
                            
                            self.showAllMapView.toggle()
                            
                        }){
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                                
                            
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    .background(Color.white)
                }
            }
            
            
            if self.loading{
                
                Loader()
                
            }
            
//            if self.book{
//
//                Booked(data: self.$data, doc: self.$doc, loading: self.$loading, book: self.$book)
//            }
            
            if self.search{
                
                SearchView(show: self.$search, map: self.$map, source: self.$source, destination: self.$destination, name: self.$name, distance: self.$distance, time: self.$time, detail: self.$showDirection)
            }
           
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: self.$alert){ () -> Alert in
            
            Alert.init(title: Text("พบข้อผิดพลาด"), message: Text("โปรดอนุญาตให้เข้าถึงตำแหน่งที่ตั้ง โดยไปที่การตั้งค่า"), dismissButton: .destructive(Text("ตกลง")))
        }
    }
    
//    func Book() {
//
//        let db = Firestore.firestore()
//        let doc = db.collection("Booking").document()
//        self.doc = doc.documentID
//
//        let from = GeoPoint(latitude: self.source.latitude, longitude: self.source.longitude)
//        let to = GeoPoint(latitude: self.destination.latitude, longitude: self.destination.longitude)
//
//        doc.setData(["name" : "Truck", "from": from,"to":to, "distance" : self.distance, "fair":(self.distance as NSString).floatValue * 1.2]) { (err) in
//
//            if err != nil {
//
//                print((err?.localizedDescription)!)
//                return
//            }
//
//            let filter = CIFilter(name: "CIQRCodeGenerator")
//            filter?.setValue(self.doc.data(using: .ascii), forKey: "inputMessage")
//
//            let image = UIImage(ciImage : (filter?.outputImage?.transformed(by: CGAffineTransform(scaleX: 5, y: 5)))!)
//            self.data = image.pngData()!
//
//            self.loading.toggle()
//            self.book.toggle()
//        }
//    }
}


struct Loader : View {
    
    @State var showLoader = false
    
    var body: some View {
        
        GeometryReader{_ in
            
            VStack(spacing: 20){
                
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: self.showLoader ? 360 : 0))
                    .onAppear{
                        
                        withAnimation(Animation.default.speed(0.45).repeatForever(autoreverses: false)){
                            
                            self.showLoader.toggle()
                        }
                    }
                
                Text("กรุณารอสักครู่....")
                    .font(.custom("Prompt-Medium", size: 18, relativeTo: .body))
            }
            .padding(.vertical,25)
            .padding(.horizontal,40)
            .background(Color.white)
            .cornerRadius(12)
            
            .padding(.leading,90)
            .padding(.top,250)
        }
        .background(Color.black.opacity(0.25).edgesIgnoringSafeArea(.all))
        
    }
}


struct MapView: UIViewRepresentable {
   
    func makeCoordinator() -> Coorditor {
        
        return MapView.Coorditor(parent1: self)
    }
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source : CLLocationCoordinate2D!
    @Binding var destination : CLLocationCoordinate2D!
    @Binding var name : String
    @Binding var distance : String
    @Binding var time : String
    @Binding var showAllMapView : Bool
    
    func makeUIView(context: Context) -> MKMapView {
           
        map.delegate = context.coordinator
        manager.delegate = context.coordinator
        map.showsUserLocation = true
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.tab(ges:)))
        map.addGestureRecognizer(gesture)
            return map
        }
    
    func updateUIView(_ view: MKMapView, context: Context) {

    }
    
    class Coorditor : NSObject,MKMapViewDelegate,CLLocationManagerDelegate {
        
        var parent : MapView
        
        init(parent1 : MapView ) {
            
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .denied{
                
                self.parent.alert.toggle()
            }
            else {
                
                self.parent.manager.startUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            
            let region = MKCoordinateRegion(center: locations.last!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.parent.source = locations.last!.coordinate
            
            self.parent.map.region = region
        }
        
        @objc func tab(ges: UITapGestureRecognizer){
            
            let location = ges.location(in: self.parent.map)
            let mplocation = self.parent.map.convert(location, toCoordinateFrom: self.parent.map)
            
            let point = MKPointAnnotation()
            point.subtitle = "Destination"
            self.parent.destination = mplocation
            
            let decoder = CLGeocoder()
            decoder.reverseGeocodeLocation(CLLocation(latitude: mplocation.latitude, longitude: mplocation.longitude)) { (places, err) in
                
                if err != nil {
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                self.parent.name = places?.first?.name ?? ""
                point.title = places?.first?.name ?? ""
                
                self.parent.showAllMapView = true
            }
            
            let req = MKDirections.Request()
            req.source = MKMapItem(placemark: MKPlacemark(coordinate: self.parent.source))
            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: mplocation))
            
            let directions = MKDirections(request: req)
            directions.calculate { (dir, err) in
                
                if err != nil {
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                let polyline = dir?.routes[0].polyline
                
                let dis = dir?.routes[0].distance as! Double
                self.parent.distance = String(format: "%.1f", dis / 1000)
                
                let time = dir?.routes[0].expectedTravelTime as! Double
                self.parent.time = String(format: "%.1f", time / 60)
                
                self.parent.map.removeOverlays(self.parent.map.overlays)
                
                self.parent.map.addOverlay(polyline!)
                
                self.parent.map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
            }
    
            point.coordinate = mplocation
            self.parent.map.removeAnnotations(self.parent.map.annotations)
            self.parent.map.addAnnotation(point)
            
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = .blue
            over.lineWidth = 3
            
            return over
        }
    }
}


//struct Booked : View {
//
//
//    @Binding var data : Data
//    @Binding var doc : String
//    @Binding var loading : Bool
//    @Binding var book : Bool
//    @State var showTableView = false
//
//    var body: some View{
//
//            //TableView(showTableView: $showTableView)
//
////        GeometryReader{_ in
////
////            VStack(spacing: 25){
////
////                Image(uiImage: UIImage(data: self.data)!)
////
////                Button(action: {
////
////                    self.loading.toggle()
////                    self.book.toggle()
////
////                    let db = Firestore.firestore()
////
////                    db.collection("Booking").document(self.doc).delete { (err) in
////
////                        if err != nil {
////
////                            print((err?.localizedDescription)!)
////                            return
////                        }
////
////                        self.loading.toggle()
////
////                    }
////
////                }) {
////
////                    Text("ยกเลิก")
////                        .font(.custom("Prompt-SemiBold", size: 16))
////                        .foregroundColor(.white)
////                        .padding(.vertical,10)
////                        .frame(width: UIScreen.main.bounds.width / 2)
////                }
////                .background(Color.red)
////                .clipShape(Capsule())
////            }
////            .padding()
////            .background(Color.white)
////            .cornerRadius(12)
////
////
////        }.padding(.top,150)
////        .padding(.leading,35)
////        .background(Color.black.opacity(0.25).edgesIgnoringSafeArea(.all))
//    }
//}
