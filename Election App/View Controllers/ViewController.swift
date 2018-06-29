//
//  ViewController.swift
//  Election App
//
//  Created by Administrator on 26/06/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMaps

struct PollingData {
    var StNo : String
    var Candidate : String
    var Votes : String
    var PartyName : String
    var Coordinates : CLLocationCoordinate2D
}

class ViewController: UIViewController {

    var Ref : DatabaseReference?
    var AssembliesData = [[PollingData]]()
    let locationManager = CLLocationManager()
    let marker = GMSMarker()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet private weak var mapCenterPinImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Polling Stations"
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        Ref = Database.database().reference()
        ReadDatabase()
        //ReadFile()
    }
    
    func ReadDatabase(){
        let Assemblies = [ "Provincial Assembly - Balouchistan", "National Assembly", "Provincial Assembly - KPK", "Provincial Assembly - Punjab", "Provincial Assembly - Sindh"]
        
        for i in 0..<Assemblies.count {
            var TempData = [PollingData]()
            Ref?.child(Assemblies[i]).observe(.value, with: {(snapshot) in
                if snapshot.childrenCount > 0 {
                    for St in snapshot.children.allObjects as! [DataSnapshot] {
                        let Obj = St.value as? [String : AnyObject]
                        let StNo = Obj?["Polling Station"] as! String
                        let Candidate = Obj?["Candidate"] as! String
                        let Votes = Obj?["Votes"] as! String
                        let PartyName = Obj?["Party Name"] as! String
                        let Cr = Obj?["Coordinates"] as! String
                        
                        let Coordi = Cr.components(separatedBy: ",")
                        let latitude = NumberFormatter().number(from: Coordi[0])?.doubleValue
                        let longitude = NumberFormatter().number(from: Coordi[1])?.doubleValue
                        let Coordinates = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                        let myObj = PollingData(StNo: StNo, Candidate: Candidate, Votes: Votes, PartyName: PartyName, Coordinates: Coordinates)
                        
                        TempData.append(myObj)
                    }
                }
                
                self.AssembliesData.append(TempData)
                if self.AssembliesData.count >= 5 {
                    self.markStations()
                }
            })
        }
    }
    
    func markStations(){
        for i in 0..<AssembliesData[1].count {
            let marker = PlaceMarker(place: AssembliesData[1][i].Coordinates)
            marker.title = AssembliesData[1][i].StNo
            marker.tracksViewChanges = true
            marker.map = self.mapView
        }
    }
    
    func ReadFile(){
        let NA_File = Bundle.main.path(forResource: "PS", ofType: "txt")
        let NA_Address_File = Bundle.main.path(forResource: "NA - Addresses", ofType: "txt")
        
        do{
            let Data1 = try String(contentsOfFile: NA_File!, encoding: String.Encoding.utf8)
            let Data2 = try String(contentsOfFile: NA_Address_File!, encoding: String.Encoding.utf8)
            let RawData1 = Data1.components(separatedBy: "\r\n")
            let RawData2 = Data2.components(separatedBy: "\r\n")
            
            AddData(Data1: RawData1, Data2: RawData2)
        }
        catch let error as NSError {
            print(error)
        }
    }

    func AddData(Data1 : [String], Data2 : [String]) {
        var i : Int = 0
        var j : Int = 0
        
        while i < Data1.count - 1 {
            let key = Ref?.child(String(j + 1)).key
            let Data = ["Polling Station" : Data1[i],
                        "Candidate" : Data1[i + 1],
                        "Party Name" : Data1[i + 2],
                        "Votes" : Data1[i + 3],
                        "Coordinates" : Data2[j]]
            
            Ref?.child(key!).setValue(Data)
            print(i)
            i += 4
            j += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:
        CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }

        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.setAllGesturesEnabled(true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        performSegue(withIdentifier: "Details", sender: self)
    }
}

