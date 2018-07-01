//
//  ViewController.swift
//  Election App
//
//  Created by Administrator on 26/06/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    var markerTapped : Int = 0
    let marker = GMSMarker()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet private weak var mapCenterPinImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Polling Stations"
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        markStations()
    }
    
    @IBAction func DoneBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let Target = segue.destination as! DetailViewController2
            Target.Index = markerTapped
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
        let values = marker.title!.components(separatedBy: "-")
        markerTapped = (NumberFormatter().number(from: values[1])?.intValue)! - 1
        
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}

