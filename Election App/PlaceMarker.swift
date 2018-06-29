import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {

    var location : CLLocationCoordinate2D
    
    init(place: CLLocationCoordinate2D) {
        self.location = place
        super.init()
        position = location
        icon = UIImage(named: "_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
}
